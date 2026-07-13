#!/usr/bin/env nextflow

params.input = null

process sayHello {
  input:
    path infile
  output:
    stdout
  script:
    """
    echo "\$(cat $infile) world!"
    """
}

workflow {
  if (params.input) {
    Channel.fromPath(params.input, checkIfExists: true) | sayHello | view
  }
  else {
    Channel.of('Bonjour', 'Ciao', 'Hello', 'Hola')
      .collectFile { greeting -> [ "${greeting}.txt", greeting ] }
      | flatten | sayHello | view
  }
}
