const apiUrl = "https://8eu6juxcs5.execute-api.eu-west-3.amazonaws.com/Test";
const cognitoPool = "anonymoose";
const clientId = "4rqnqkbgh58bi63i4ffgi8jihs";
const redirectUrl = "myapp://";
const redirectUrlWithCode = "$redirectUrl?code=";
const authUrl = "https://$cognitoPool.auth.eu-west-3.amazoncognito.com/login?client_id=$clientId&response_type=code&scope=email+openid&redirect_uri=$redirectUrl";
const tokenUrl = "https://$cognitoPool.auth.eu-west-3.amazoncognito.com/oauth2/token?client_id=$clientId&grant_type=authorization_code&redirect_uri=$redirectUrl";
