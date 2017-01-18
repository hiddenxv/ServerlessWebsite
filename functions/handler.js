'use strict';

// Your first function handler
module.exports.hello = ( event, context, cb ) => 
{
  var renderedPage = 'hello serverless';
  cb( null, renderedPage );
};

// You can add more handlers here, and reference them in serverless.yml

function renderContent( renderedPage ) 
{
  return `
  <html>
    <body>
      <h1>Serverless Website</h1>
      ${renderedPage}
    </body>
  </html>`;
}
