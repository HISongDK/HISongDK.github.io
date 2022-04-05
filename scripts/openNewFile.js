var spawn = require('child_process').spawn
hexo.on('new', function (data) {
    spawn('C:\\Users\\song\\AppData\\Local\\Programs\\Microsoft VS Code\\Code.exe', [data.path])
})
