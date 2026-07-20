#!/usr/bin/env nextflow

params.input = null

process sayHello {
  container '651706780852.dkr.ecr.us-east-1.amazonaws.com/sushma-wave-blobcache-mirror-test:latest'

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
