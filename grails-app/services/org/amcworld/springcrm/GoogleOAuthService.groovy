/*
 * GoogleOAuthService.groovy
 *
 * Copyright (c) 2011-2013, Daniel Ellermann
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


package org.amcworld.springcrm

import com.google.api.client.auth.oauth2.Credential
import com.google.api.client.http.HttpResponseException
import org.amcworld.springcrm.google.ProxyAuthorizationCodeFlow
import org.amcworld.springcrm.google.ProxyCredential
import org.amcworld.springcrm.google.UserCredentialStore


/**
 * The class {@code GoogleOAuthService} represents a service which performs
 * the OAuth2 authentication at the Google services.  In order to work with
 * different installations the services uses a proxy at AMC World for OAuth2
 * authentication.
 *
 * @author  Daniel Ellermann
 * @version 1.4
 * @since   1.0
 */
class GoogleOAuthService extends GoogleService {

    //-- Public methods -------------------------

    /**
     * Gets the authorization code flow to obtain credential for the Google API
     * via the AMC World proxy.
     *
     * @return  the authorization code flow instance
     */
    ProxyAuthorizationCodeFlow getAuthorizationCodeFlow() {
        def flow = new ProxyAuthorizationCodeFlow(HTTP_TRANSPORT, JSON_FACTORY)
        flow.credentialStore = new UserCredentialStore()
        flow
    }

    /**
     * Loads the credential for the given user from the underlying store.  The
     * method automatically refreshes the credential if it has expired.
     *
     * @param userName  the name of the user; {@code null} to obtain the user
     *                  name from the current session
     * @return          the credential; {@code null} if no credential has been
     *                  stored
     */
    Credential loadCredential(CharSequence userName = null) {
        ProxyCredential credential =
            authorizationCodeFlow.loadCredential(fixUserName(userName))
        if (credential && credential.expiresInSeconds <= 0) {
            credential.refreshToken()
        }
        credential
    }

    /**
     * Obtains the credential, that is the access and refresh tokens, from the
     * proxy and stores them in the underlying store.
     *
     * @param clientId  the client ID generated by the proxy; used to obtain
     *                  the credential from the proxy
     * @param userName  the name of the user; {@code null} to obtain the user
     *                  name from the current session
     * @return          {@code true} if the credential was obtained and stored
     *                  successfully; {@code false} otherwise
     */
    boolean obtainAndStoreCredential(CharSequence clientId,
                                     CharSequence userName = null)
    {
        try {
            authorizationCodeFlow.obtainAndStoreCredential(
                fixUserName(userName), clientId.toString()
            )
            true
        } catch (HttpResponseException e) {
            false
        }
    }

    /**
     * Registers this application as a client at the OAuth proxy for further
     * authentication.
     *
     * @param redirectUrl   the URL which is to call when the proxy has
     *                      received the credential
     * @return              a URL to redirect the user to in order to
     *                      authenticate at the server; {@code null} if no such
     *                      URL could be obtained
     */
    String registerAtProxy(CharSequence redirectUrl) {
        try {
            authorizationCodeFlow.register redirectUrl.toString()
        } catch (HttpResponseException e) {
            null
        }
    }

    /**
     * Revokes access to the server by sending a revoke request to the proxy
     * and deleting the credential in the underlying store.
     *
     * @param userName  the name of the user; {@code null} to obtain the user
     *                  name from the current session
     */
    void revokeAtProxy(CharSequence userName = null) {
        authorizationCodeFlow.revoke fixUserName(userName)
    }


    //-- Non-public methods ---------------------

    /**
     * Returns the given userName, or if it is {@code null}, obtains the user
     * name from the current session.
     *
     * @param userName  the given user name; may be {@code null}
     * @return          the user name
     */
    protected String fixUserName(CharSequence userName) {
        (userName == null) ? session.user.userName : userName.toString()
    }
}
