import paramiko
output_file = 'paramiko.org'


def paramiko_GKG(hostname, command):
	print('running')
	try:
		port = '22'
		
		# created client using paramiko
		client = paramiko.SSHClient()
		
		# here we are loading the system
		# host keys
		client.load_system_host_keys()
		
		# connecting paramiko using host
		# name and password
		client.connect(hostname, port=22, username='geeksForgeeks',
					password='geeksForgeeks')
		
		# below line command will actually
		# execute in your remote machine
		(stdin, stdout, stderr) = client.exec_command(command)
		
		# redirecting all the output in cmd_output
		# variable
		cmd_output = stdout.read()
		print('log printing: ', command, cmd_output)
		
		# we are creating file which will read our
		# cmd_output and write it in output_file
		with open(output_file, "w+") as file:
			file.write(str(cmd_output))
			
		# we are returning the output
		return output_file
	finally:
		client.close()


paramiko_GKG('10.10.10.1', 'uname')
