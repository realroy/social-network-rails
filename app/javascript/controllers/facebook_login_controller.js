import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    window.fbAsyncInit = () => {
      FB.init({
        appId: '189067969939651',
        cookie: true,                     // Enable cookies to allow the server to access the session.
        xfbml: true,                     // Parse social plugins on this webpage.
        version: 'v13.0'           // Use this Graph API version for this call.
      });

      FB.getLoginStatus(this.statusChangeCallback);
    };
  }

  statusChangeCallback(response) {  // Called with the results from FB.getLoginStatus().
    console.log('statusChangeCallback');
    console.log(response);                   // The current login status of the person.
    if (response.status === 'connected') {   // Logged into your webpage and Facebook.
      this.testAPI();
    } else {                                 // Not logged into your webpage or we are unable to tell.
      // document.getElementById('status').innerHTML = 'Please log ' +
      //     'into this webpage.';
    }
  }

  testAPI() {                      // Testing Graph API after login.  See statusChangeCallback() for when this call is made.
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function (response) {
      console.log('Successful login for: ' + response.name);
      document.getElementById('status').innerHTML =
          'Thanks for logging in, ' + response.name + '!';
    });
  }

  checkLoginState() {               // Called when a person is finished with the Login Button.
    FB.getLoginStatus(this.statusChangeCallback);
  }

  get sessionPath() {
    return document.head.querySelector('meta[name="session_path"]').content
  }

  login() {
    FB.login(response => {
      const {authResponse} = response
      if (authResponse) {
        console.log(authResponse);

        FB.api('/me', async (me) => {
          console.log({me})
          const res = await fetch(this.sessionPath, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              sessions: {
                provider_name: 'facebook',
                token: authResponse.accessToken,
                expired_at: authResponse.data_access_expiration_time,
                user_id: me.id,
                name: me.name
              }
            })
          })

          const { redirect_url } = await res.json()

          Turbo.visit(redirect_url)
        });
      } else {
        console.log('User cancelled login or did not fully authorize.');
      }
    }, {scope: 'email,public_profile', return_scopes: true, auth_type: 'reauthorize', enable_profile_selector: true})
  }

  async signOut() {
    FB.logout()
    try {
      await fetch(this.sessionPath, {method: 'DELETE'})
    } finally {
      Turbo.visit('/', { action: 'replace', method: 'GET' })
    }
  }
}
