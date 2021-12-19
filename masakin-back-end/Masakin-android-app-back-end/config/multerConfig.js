const multer = require('multer');
const path = require('path');
// Multer config
module.exports = multer({
  storage: multer.diskStorage({}),
  fileFilter: (req, file, cb) => {
    let ext = path.extname(file.originalname);
    if (ext !== '.jpg' && ext !== '.jpeg' && ext !== '.png') {
      cb(new Error('File type is not supported'), false);
      return;
    }
    cb(null, true);
  },
});

// const multer = require('multer')
// const Datauri = require('datauri/parser')
// const path = require('path')

// // const storage = multer.memoryStorage()
// // const multerUploads = multer({storage})

// // const dUri = new Datauri()

// // const datauri = req => dUri.format(path.extname(req.file.originalname).toString(), req.file.buffer)

// module.exports = {
//     multerUploads,
//     datauri
// }