{exec} = require 'child_process'

task 'sbuild', 'Build project from src/coffee/*.coffee to bin/assets/js/*.js', ->
  exec 'coffee --compile --output bin/assets/js/ src/coffee/', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
