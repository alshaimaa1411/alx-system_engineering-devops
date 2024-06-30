#creat_file
file {'/tmp/school':
        ensure  => present,           # Ensure the file exists
        content => "I love Puppet",
        owner   => 'www-data',            # Set file owner
        group   => 'root',            # Set file group
        mode    => 'www-data',            # Set file permissions
        permissions => '0744',
    }
