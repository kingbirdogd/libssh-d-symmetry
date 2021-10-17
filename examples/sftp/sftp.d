module sftp;

import core.stdc.stdlib;
import std.stdio;
import std.string;
import std.file;
import std.path;

import libssh.session;
import libssh.sftp;
import libssh.c_bindings.sftp;
import libssh.utils;
import libssh.errors;

import connect_ssh;

version(Windows)
{
	import core.stdc.stdio;
}
else
{
	import core.sys.posix.fcntl;
}


int main(string[] argv)
{
    import std.stdio;
    auto session = new SSHSession();
    session.logVerbosity = LogVerbosity.NoLog;
    auto host = argv[1];
    auto user = argv[2];
    auto pass = argv[3];
    session.user = user;
    session.host = host;
    session.connect();
    auto rc = session.userauthPassword(user, pass);
    if (AuthState.Success != rc)
    {
        writeln("auth fail");
        return -1;	
    }
    writeln("auth success");
    auto sftp=session.newSFTP();
    int access_type = O_CREAT | O_WRONLY | O_TRUNC;
    uint mode = S_IRWXU;
    auto file_path="my_test.txt";
    auto content="abcd\n";
    auto buffer = cast(ubyte[])content;
    auto file = sftp.open(file_path, access_type, mode);
    file.write(buffer);
    file.close();
    sftp.dispose();
    session.disconnect();
    return 0;
}
