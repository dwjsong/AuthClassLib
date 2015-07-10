using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mime;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;

namespace CST
{

    public class DLLServerUploader
    {
        public static string CSTFolder = @"C:\CST";
        public static string methodsFolderName = "methods";
        public static string dllFolderName = "dlls";
        public static string methodsFolder = CSTFolder + @"\" + methodsFolderName + @"\";
        public static string dllsFolder = CSTFolder + @"\" + dllFolderName + @"\";
        public static string server_url = "http://protoagnostic.cloudapp.net:8600/";
        public static string depdown_page = "CST_Support_DepDown.aspx";
        public static string dlldown_page = "CST_Support_DllDown.aspx";
        public static string methoddown_page = "CST_Support_MethodDown.aspx";
        public static string dllanddepUp_page = "CST_Support_up.aspx";
        public static string methodup_page = "CST_Support_MethodUp.aspx";
        public static string sha_parameter_name = "USER_SHA";
        public static string dllname_parameter_name = "DLL_NAME";

        public class FileParameter
        {
            public byte[] File { get; set; }
            public string FileName { get; set; }
            public string ContentType { get; set; }
            public FileParameter(byte[] file) : this(file, null) { }
            public FileParameter(byte[] file, string filename) : this(file, filename, null) { }
            public FileParameter(byte[] file, string filename, string contenttype)
            {
                File = file;
                FileName = filename;
                ContentType = contenttype;
            }
        }

        public DLLServerUploader()
        {
            if (HttpContext.Current != null)
            {
                Configuration webConfig = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);

                if (webConfig.AppSettings.Settings.Count > 0)
                {
                    KeyValueConfigurationElement customSetting =
                        webConfig.AppSettings.Settings["CSTFolderPath"];
                    if (customSetting != null)
                    {
                        CSTFolder = customSetting.Value;
                    }

                    KeyValueConfigurationElement dllSetting =
                        webConfig.AppSettings.Settings["DLLServerAddress"];
                    if (customSetting != null)
                    {
                        server_url = dllSetting.Value;
                    }
                }

                methodsFolder = CSTFolder + @"\" + methodsFolderName;
                dllsFolder = CSTFolder + @"\" + dllFolderName;
            }
        }

        public void uploadMethodRecord(string filePath, string sha)
        {
            FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            byte[] data = new byte[fs.Length];
            fs.Read(data, 0, data.Length);
            fs.Close();

            string fileName = Path.GetFileName(filePath);
            // Generate post objects
            Dictionary<string, object> postParameters = new Dictionary<string, object>();
            postParameters.Add("file", new FileParameter(data, fileName, "application/octet-stream"));

            string url = server_url + methodup_page + "?" + sha_parameter_name + "=" + sha;

            uploadFile(postParameters, url);
        }

        public void uploadDllDep(string dllFilePath, string depFilePath, string sha)
        {
            FileStream fs = new FileStream(dllFilePath, FileMode.Open, FileAccess.Read);
            byte[] dllData = new byte[fs.Length];
            fs.Read(dllData, 0, dllData.Length);
            fs.Close();

            fs = new FileStream(depFilePath, FileMode.Open, FileAccess.Read);
            byte[] depData = new byte[fs.Length];
            fs.Read(depData, 0, depData.Length);
            fs.Close();

            string dllFileName = Path.GetFileName(dllFilePath);
            string depFileName = Path.GetFileName(depFilePath);

            // Generate post objects
            Dictionary<string, object> postParameters = new Dictionary<string, object>();
            postParameters.Add("file", new FileParameter(dllData, dllFileName, "application/octet-stream"));
            postParameters.Add("file2", new FileParameter(depData, depFileName, "application/octet-stream"));

            string url = server_url + dllanddepUp_page + "?" + sha_parameter_name + "=" + sha;

            uploadFile(postParameters, url);

        }

        private void uploadFile(Dictionary<string, object> postParameters, string url)
        {
            HttpWebResponse webResponse = MultipartFormDataPost(url, "Uploader", postParameters);

            webResponse.Close();
        }

        private static readonly Encoding encoding = Encoding.UTF8;
        public HttpWebResponse MultipartFormDataPost(string postUrl, string userAgent, Dictionary<string, object> postParameters)
        {
            string formDataBoundary = String.Format("----------{0:N}", Guid.NewGuid());
            string contentType = "multipart/form-data; boundary=" + formDataBoundary;

            byte[] formData = GetMultipartFormData(postParameters, formDataBoundary);

            return PostForm(postUrl, userAgent, contentType, formData);
        }

        private HttpWebResponse PostForm(string postUrl, string userAgent, string contentType, byte[] formData)
        {
            HttpWebRequest request = WebRequest.Create(postUrl) as HttpWebRequest;

            if (request != null)
            {

                // Set up the request properties.
                request.Method = "POST";
                request.ContentType = contentType;
                request.UserAgent = userAgent;
                request.CookieContainer = new CookieContainer();
                request.ContentLength = formData.Length;

                // You could add authentication here as well if needed:
                // request.PreAuthenticate = true;
                // request.AuthenticationLevel = System.Net.Security.AuthenticationLevel.MutualAuthRequested;
                // request.Headers.Add("Authorization", "Basic " + Convert.ToBase64String(System.Text.Encoding.Default.GetBytes("username" + ":" + "password")));

                // Send the form data to the request.
                using (Stream requestStream = request.GetRequestStream())
                {
                    requestStream.Write(formData, 0, formData.Length);
                    requestStream.Close();
                }


                return request.GetResponse() as HttpWebResponse;
            }
            return null;
        }

        private byte[] GetMultipartFormData(Dictionary<string, object> postParameters, string boundary)
        {
            Stream formDataStream = new System.IO.MemoryStream();
            bool needsCLRF = false;

            foreach (var param in postParameters)
            {
                // Thanks to feedback from commenters, add a CRLF to allow multiple parameters to be added.
                // Skip it on the first parameter, add it to subsequent parameters.
                if (needsCLRF)
                    formDataStream.Write(encoding.GetBytes("\r\n"), 0, encoding.GetByteCount("\r\n"));

                needsCLRF = true;

                if (param.Value is FileParameter)
                {
                    FileParameter fileToUpload = (FileParameter)param.Value;

                    // Add just the first part of this param, since we will write the file data directly to the Stream
                    string header = string.Format("--{0}\r\nContent-Disposition: form-data; name=\"{1}\"; filename=\"{2}\";\r\nContent-Type: {3}\r\n\r\n",
                        boundary,
                        param.Key,
                        fileToUpload.FileName ?? param.Key,
                        fileToUpload.ContentType ?? "application/octet-stream");

                    formDataStream.Write(encoding.GetBytes(header), 0, encoding.GetByteCount(header));

                    // Write the file data directly to the Stream, rather than serializing it to a string.
                    formDataStream.Write(fileToUpload.File, 0, fileToUpload.File.Length);
                }
                else
                {
                    string postData = string.Format("--{0}\r\nContent-Disposition: form-data; name=\"{1}\"\r\n\r\n{2}",
                        boundary,
                        param.Key,
                        param.Value);
                    formDataStream.Write(encoding.GetBytes(postData), 0, encoding.GetByteCount(postData));
                }
            }

            // Add the end of the request.  Start with a newline
            string footer = "\r\n--" + boundary + "--\r\n";
            formDataStream.Write(encoding.GetBytes(footer), 0, encoding.GetByteCount(footer));

            // Dump the Stream into a byte[]
            formDataStream.Position = 0;
            byte[] formData = new byte[formDataStream.Length];
            formDataStream.Read(formData, 0, formData.Length);
            formDataStream.Close();

            return formData;
        }
    }

    public class DLLServerDownloader
    {
        public static string CSTFolder = @"C:\CST";
        public static string methodsFolderName = "methods";
        public static string dllFolderName = "dlls";
        public static string methodsFolder = CSTFolder + @"\" + methodsFolderName + @"\";
        public static string dllsFolder = CSTFolder + @"\" + dllFolderName + @"\";
        public static string server_url = "http://protoagnostic.cloudapp.net:8600/";
        public static string depdown_page = "CST_Support_DepDown.aspx";
        public static string dlldown_page = "CST_Support_DllDown.aspx";
        public static string methoddown_page = "CST_Support_MethodDown.aspx";
        public static string dllanddepUp_page = "CST_Support_up.aspx";
        public static string methodup_page = "CST_Support_MethodUp.aspx";
        public static string sha_parameter_name = "USER_SHA";
        public static string dllname_parameter_name = "DLL_NAME";

        public DLLServerDownloader()
        {
            if (HttpContext.Current != null)
            {
                Configuration webConfig = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);

                if (webConfig.AppSettings.Settings.Count > 0)
                {
                    KeyValueConfigurationElement customSetting =
                        webConfig.AppSettings.Settings["CSTFolderPath"];
                    if (customSetting != null)
                    {
                        CSTFolder = customSetting.Value;
                    }

                    KeyValueConfigurationElement dllSetting =
                        webConfig.AppSettings.Settings["DLLServerAddress"];
                    if (customSetting != null)
                    {
                        server_url = dllSetting.Value;
                    }
                }

                methodsFolder = CSTFolder + @"\" + methodsFolderName;
                dllsFolder = CSTFolder + @"\" + dllFolderName;
            }
        }

        private static void downloadFile(string path, string url)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(url);
            httpWebRequest.ReadWriteTimeout = 500;
            httpWebRequest.ContentType = "application/octet-stream";
            httpWebRequest.Accept = "*/*";
            httpWebRequest.Method = "GET";

            using (WebResponse response = httpWebRequest.GetResponse())
            {
                var content = response.Headers.GetValues("Content-Disposition");

                if (content != null)
                {
                    var header_list = content.ToList();

                    string filename = "";

                    if (header_list.Count > 0)
                        filename = new ContentDisposition(header_list[0]).FileName;
                    else
                        filename = "temp.txt";

                    using (Stream stream = response.GetResponseStream())
                    {
                        using (MemoryStream ms = new MemoryStream())
                        {
                            stream.CopyTo(ms);

                            try
                            {
                                File.WriteAllBytes(path + filename, ms.ToArray());
                            }
                            catch (IOException)
                            {
                            }
                        }
                    }
                }
            }
        }

        public static void downloadDLLandDep(string sha)
        {
            downloadFile(dllsFolder + sha + "\\", server_url + depdown_page + "?" + sha_parameter_name + "=" + sha);
            downloadFile(dllsFolder + sha + "\\", server_url + dlldown_page + "?" + sha_parameter_name + "=" + sha);
        }

        public static void downloadMethodRecord(string sha)
        {
            downloadFile(methodsFolder, server_url + methoddown_page + "?" + sha_parameter_name + "=" + sha);
        }

    }
}
