<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="OpenIDExample.LogIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    	<label for="openid_identifier">OpenID: </label>
	    <input id="openid_identifier" name="openid_identifier" size="40" />
	    <input type="submit" value="Login" />

    </div>
    </form>
</body>
</html>
