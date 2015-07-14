using System.Diagnostics.Contracts;
using GenericAuthNameSpace;
using LiveIDNameSpace;
using OpenIDConnectNameSpace;
using CST;

class PoirotMain
{
    static NondetOpenIDConnect Nondet;
    class GlobalObjectsForCST : GlobalObjects_base
    {
        static public void init()
        {
            SignInIdP_Req=Nondet.AuthenticationRequest();
            IdP = new LiveID_IdP(); ((LiveID_IdP)IdP).init();
            RP=new LiveID_RP_For_vProgram();
        }
    }
    static void Main() 
    {
        //SymT
        /*   a.local.host:#drawConclusion((
                   login.live.com:#TokenEndpoint((
                       a.local.host:#constructTokenRequest(
             )))))
        */

        GlobalObjectsForCST.init();
        AuthenticationResponse AuthenticationUsingAuthorizationCodeFlow_in = Nondet.AuthenticationResponse();
        bool AuthenticationUsingAuthorizationCodeFlow_out = ((LiveID_RP_For_vProgram)GlobalObjectsForCST.RP).AuthenticationUsingAuthorizationCodeFlow(AuthenticationUsingAuthorizationCodeFlow_in);
        /*
         AuthenticationResponse constructTokenRequest_in = Nondet.AuthenticationResponse();

        TokenRequest constructTokenRequest_out=
            ((LiveID_RP_For_vProgram)GlobalObjectsForCST.RP).constructTokenRequest(constructTokenRequest_in);

        if (constructTokenRequest_out==null)
            return;

        TokenRequest TokenEndpoint_in = constructTokenRequest_out;
        TokenResponse TokenEndpoint_out= 
            ((LiveID_IdP)GlobalObjectsForCST.IdP).TokenEndpoint(TokenEndpoint_in);
        if (TokenEndpoint_out==null)
            return;

        TokenResponse drawConclusion_in = TokenEndpoint_out;

        _RP.AuthenticationConclusion drawConclusion_out=
               ((LiveID_RP_For_vProgram)GlobalObjectsForCST.RP).drawConclusion(drawConclusion_in);

        if (drawConclusion_out == null)
            return;
        ((LiveID_RP_For_vProgram)GlobalObjectsForCST.RP).AuthenticationDone(drawConclusion_out);*/

    }
}