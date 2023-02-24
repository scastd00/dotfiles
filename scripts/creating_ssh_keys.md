# SSH key generation

In the host that will be used to connect to the remote server, you need to generate an SSH key pair.
This key pair will be used to authenticate the connection between the host and the remote server.

## Generating the SSH key pair

To generate the SSH key pair, you need to run the following command:

```bash
ssh-keygen -t ed25519 -C "user@host"
```

This command will generate a private key and a public key. The private key will be stored in the file `~/.ssh/id_ed25519` and the
public key will be stored in the file `~/.ssh/id_ed25519.pub`. The public key is the one that will be stored in
the server, to allow the host to connect to it.

## Storing the public key in the server

To store the public key in the server, there are two options:

### Using the `ssh-copy-id` command

```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@host
```

This command will copy the public key to the server, and will add it to the `~/.ssh/authorized_keys` file.

### Manually

If the command fails, you need to create the `~/.ssh/authorized_keys` file in the server, and add the public key to it manually.

## Add the key to the config file

The config file allows you to connect to a host in an easier way, since you don't need to specify the user and the host every time you connect to it. To add the key to the config file, you need to add
the following lines to the `~/.ssh/config` file:

```bash
Host nameOfTheHost
    HostName host
    User user
    IdentityFile ~/.ssh/id_ed25519
```
