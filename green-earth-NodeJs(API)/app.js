const Readable = require("stream").Readable;
const express = require("express");
const router = express.Router();
const fs = require("fs");
const readline = require("readline");
const { google } = require("googleapis");
const multer = require("multer");
const upload = multer();
const requireLogin = require("./middleware/auth")
const User = require("./Models/User");

const SCOPES = ["https://www.googleapis.com/auth/drive"];


const TOKEN_PATH = "token.json";

function bufferToStream(buffer) {
  var stream = new Readable();
  stream.push(buffer);
  stream.push(null);

  return stream;
}




router.post("/uploadphoto",requireLogin, upload.single("image"), (req, res) => {
  // Load client secrets from a local file.
  console.log(req.file + "harry upload");
  fs.readFile("credentials.json", (err, content) => {
    if (err) return console.log("Error loading client secret file:", err);
    // Authorize a client with credentials, then call the Google Drive API.
    // authorize(JSON.parse(content), listFiles);
    authorize(JSON.parse(content), storeFiles);
  });


  function authorize(credentials, callback) {
    const { client_secret, client_id, redirect_uris } = credentials.installed;
    const oAuth2Client = new google.auth.OAuth2(
      client_id,
      client_secret,
      redirect_uris[0]
    );

    // Check if we have previously stored a token.
    fs.readFile(TOKEN_PATH, (err, token) => {
      if (err) return getAccessToken(oAuth2Client, callback);
      oAuth2Client.setCredentials(JSON.parse(token));
      callback(oAuth2Client);
    });
  }


  function getAccessToken(oAuth2Client, callback) {
    const authUrl = oAuth2Client.generateAuthUrl({
      access_type: "offline",
      scope: SCOPES,
    });
    console.log("Authorize this app by visiting this url:", authUrl);
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout,
    });
    rl.question("Enter the code from that page here: ", (code) => {
      rl.close();
      oAuth2Client.getToken(code, (err, token) => {
        if (err) return console.error("Error retrieving access token", err);
        oAuth2Client.setCredentials(token);
        // Store the token to disk for later program executions
        fs.writeFile(TOKEN_PATH, JSON.stringify(token), (err) => {
          if (err) return console.error(err);
          console.log("Token stored to", TOKEN_PATH);
        });
        callback(oAuth2Client);
      });
    });
  }



  function storeFiles(auth) {
    // console.log("auth", JSON.stringify(auth));
    console.log("store files");
    const drive = google.drive({ version: "v3", auth });
    var fileMetadata = {
      name: "ImageTest.jpeg",
    };
    console.log(req.file.path);
    var media = {
      mimeType: "image/jpeg",
      //PATH OF THE FILE FROM YOUR COMPUTER

      //   body: fs.createReadStream(req.file.buffer)
      body: bufferToStream(req.file.buffer),
    };
    drive.files.create(
      {
        resource: fileMetadata,
        media: media,
        fields: "id",
      },
      function (err, file) {
        if (err) {
          res.status(500).send({ err });
        } else {
          // console.log('File Id: ', file.data.id);
          const postdata = {
            datedata : new Date(),
            status : true,
            postgoogleid: file.data.id
          }
          User.findByIdAndUpdate(
            req.user._id,
            {
              // $push: { postDates: new Date() },
              $push: { postDates: postdata },
            },
            {
              new: true,
            }
          ).exec((error, result) => {
            if (error) {
              return res.status(422).json({ error: error });
            } else {
              res.status(200).send({ msg: "image saved successfully" });
            }
          });
        }
      }
    );
  }
});





router.post('/setstatustrue', (req,res) => {
  // Load client secrets from a local file.
      
      fs.readFile('credentials.json', (err, content) => {
        if (err) return console.log('Error loading client secret file:', err);
        // Authorize a client with credentials, then call the Google Drive API.
        authorize(JSON.parse(content), deletefile);
        // authorize(JSON.parse(content), storeFiles);
      });

    
      function authorize(credentials, callback) {
        const {client_secret, client_id, redirect_uris} = credentials.installed;
        const oAuth2Client = new google.auth.OAuth2(
            client_id, client_secret, redirect_uris[0]);

        // Check if we have previously stored a token.
        fs.readFile(TOKEN_PATH, (err, token) => {
          if (err) return getAccessToken(oAuth2Client, callback);
          oAuth2Client.setCredentials(JSON.parse(token));
          callback(oAuth2Client);
        });
      }

      function getAccessToken(oAuth2Client, callback) {
        const authUrl = oAuth2Client.generateAuthUrl({
          access_type: 'offline',
          scope: SCOPES,
        });
        console.log('Authorize this app by visiting this url:', authUrl);
        const rl = readline.createInterface({
          input: process.stdin,
          output: process.stdout,
        });
        rl.question('Enter the code from that page here: ', (code) => {
          rl.close();
          oAuth2Client.getToken(code, (err, token) => {
            if (err) return console.error('Error retrieving access token', err);
            oAuth2Client.setCredentials(token);
            // Store the token to disk for later program executions
            fs.writeFile(TOKEN_PATH, JSON.stringify(token), (err) => {
              if (err) return console.error(err);
              console.log('Token stored to', TOKEN_PATH);
            });
            callback(oAuth2Client);
          });
        });
      }

      
      function deletefile(auth) {
        const fileId = req.body.fileId;
        const drive = google.drive({version: 'v3', auth});
       
        drive.files.delete({fileId:fileId})
        .then(result => {
          User.updateOne({"postDates.postgoogleid":fileId},
          {$set: {"postDates.$.status": true}}
          )
          .then(doc => {
              // return  res.send("updated successfully");
              res.json({fileId : fileId})
          })
          .catch(err => {
              console.log(err)
          })
        })
        .catch((err) => {
          console.log(err);
        })
      }
})  



router.post('/setstatusfalse', (req,res) => {
  // Load client secrets from a local file.
      
      fs.readFile('credentials.json', (err, content) => {
        if (err) return console.log('Error loading client secret file:', err);
        // Authorize a client with credentials, then call the Google Drive API.
        authorize(JSON.parse(content), deletefile);
        // authorize(JSON.parse(content), storeFiles);
      });

    
      function authorize(credentials, callback) {
        const {client_secret, client_id, redirect_uris} = credentials.installed;
        const oAuth2Client = new google.auth.OAuth2(
            client_id, client_secret, redirect_uris[0]);

        // Check if we have previously stored a token.
        fs.readFile(TOKEN_PATH, (err, token) => {
          if (err) return getAccessToken(oAuth2Client, callback);
          oAuth2Client.setCredentials(JSON.parse(token));
          callback(oAuth2Client);
        });
      }

      function getAccessToken(oAuth2Client, callback) {
        const authUrl = oAuth2Client.generateAuthUrl({
          access_type: 'offline',
          scope: SCOPES,
        });
        console.log('Authorize this app by visiting this url:', authUrl);
        const rl = readline.createInterface({
          input: process.stdin,
          output: process.stdout,
        });
        rl.question('Enter the code from that page here: ', (code) => {
          rl.close();
          oAuth2Client.getToken(code, (err, token) => {
            if (err) return console.error('Error retrieving access token', err);
            oAuth2Client.setCredentials(token);
            // Store the token to disk for later program executions
            fs.writeFile(TOKEN_PATH, JSON.stringify(token), (err) => {
              if (err) return console.error(err);
              console.log('Token stored to', TOKEN_PATH);
            });
            callback(oAuth2Client);
          });
        });
      }

      
      function deletefile(auth) {
        const fileId = req.body.fileId;
        const drive = google.drive({version: 'v3', auth});
       
        drive.files.delete({fileId:fileId})
        .then(result => {
          User.updateOne({"postDates.postgoogleid":fileId},
          {$set: {"postDates.$.status": false}}
          )
          .then(doc => {
              // return  res.send("updated successfully");
              res.json({fileId : fileId})
          })
          .catch(err => {
              console.log(err)
          })
        })
        .catch((err) => {
          console.log(err);
        })
      }
})  





router.get('/imagedata', (req,res) => {
  // Load client secrets from a local file.
 
fs.readFile('credentials.json', (err, content) => {
  if (err) return console.log('Error loading client secret file:', err);
  // Authorize a client with credentials, then call the Google Drive API.
  authorize(JSON.parse(content), listFiles);
  // authorize(JSON.parse(content), storeFiles);
});


function authorize(credentials, callback) {
  const {client_secret, client_id, redirect_uris} = credentials.installed;
  const oAuth2Client = new google.auth.OAuth2(
      client_id, client_secret, redirect_uris[0]);

  // Check if we have previously stored a token.
  fs.readFile(TOKEN_PATH, (err, token) => {
    if (err) return getAccessToken(oAuth2Client, callback);
    oAuth2Client.setCredentials(JSON.parse(token));
    callback(oAuth2Client);
  });
}


function getAccessToken(oAuth2Client, callback) {
  const authUrl = oAuth2Client.generateAuthUrl({
    access_type: 'offline',
    scope: SCOPES,
  });
  console.log('Authorize this app by visiting this url:', authUrl);
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });
  rl.question('Enter the code from that page here: ', (code) => {
    rl.close();
    oAuth2Client.getToken(code, (err, token) => {
      if (err) return console.error('Error retrieving access token', err);
      oAuth2Client.setCredentials(token);
      // Store the token to disk for later program executions
      fs.writeFile(TOKEN_PATH, JSON.stringify(token), (err) => {
        if (err) return console.error(err);
        console.log('Token stored to', TOKEN_PATH);
      });
      callback(oAuth2Client);
    });
  });
}

function listFiles(auth) {
  const drive = google.drive({version: 'v3', auth});
  drive.files.list({
    pageSize: 50,
    fields: 'nextPageToken, files(id, name, thumbnailLink)',
  }, (err, resp) => {
    if (err) return console.log('The API returned an error: ' + err);
    const files = resp.data.files;
    if (files.length) {
      // console.log('Files:');
      // files.map((file) => {
      //   console.log(`${file.name} (${file.id})`);
      // });
      res.status(200).send(files)
 
    } else {
      console.log('No files found.');
    }
  });
}


})  










module.exports = router;
