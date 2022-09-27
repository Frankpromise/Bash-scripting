Shell Scripting
Shebang line
Shell scripts typically begin with the shebang line:  #!path/to/interpreter .
#!  is a human-readable representation of a magic number  0x23 0x21  which can tell
the shell to pass execution of the rest of the file to a specified interpreter. If
your script is run as an executable (e.g.  ./my_shell_script ) with a shebang line,
then the shell will invoke the executable (usually an interpreter) at
path/to/interpreter  to run your script. If your script is passed as an argument to an
interpreter e.g.  bash my_shell_script , then the shebang has no effect and  bash  will
handle the script’s execution.
Why is this important? The shebang line can be considered a useful piece of metadata
which passes the concern of how a script is executed from the user to the program’s
author.  my_shell_script  could be a  bash  script, a  python  script, a  ruby  script,
etc. The idea is that only the script’s behavior, not its implementation details,
should matter to the user who calls the script.
You may have seen some variant of  #!/bin/sh . Although initially referencing the
Bourne shell, on modern systems sh has come to reference to the Shell Command
Language, which is a POSIX specification with many implementations.  sh  is usually
symlinked to one of these POSIX-compliant shells which implement the Shell Command
Language. On Debian, for instance,  sh  is symlinked to the shell  dash . It is
important to note that  bash  does not fully comply with this standard, although
running  bash  as  bash --posix  makes it more compliant.
Piping
We can use the  |  character to chain multiple commands together in one line. For
instance:  command1 | command2  will pass the output of  command1  as the input to
command2 . We can repeat this as many times as we need.
Useful Commands
cat
cat  prints files to the standard output. Very useful for printing something to pipe
into other commands!
cut (https://man7.org/linux/man-pages/man1/cut.1.html)
cut [options] [filename]  extracts certain parts of a file (or piped-in input) based
on the arguments that are used. A few which might be useful:
-d  allows us to change the delimeter, or change the character  cut  looks for
to divide the string into chunks. If this option is omitted,  tab  is used.
-f  allows us to specify a number corresponding to the field to return, e.g.
cut -f1 -d" "  would return the first word in a sentence. The number followed
by a  -  returns all fields after the specified field as well, so  cut -f1- -d"
"  would return the entire string.
--complement  tells cut to return evertything except for the specified field.
grep (https://man7.org/linux/man-pages/man1/grep.1.html)
grep [pattern] [filename]  filters out and returns lines from a file (or piped-
in input) that contain the specified pattern.
sed (https://man7.org/linux/man-pages/man1/sed.1.html)
sed  can do many things, such as editing strings and matching regex. We can use
sed  to replace one pattern with another pattern as follows:
sed 's/<PATTERN-TO-REPLACE>/<NEW-PATTERN>/g <INPUT>'
sed  can also take piped-in input from something else instead of an explicit
input. The  g  at the end tells sed to replace all ocurrences of the pattern; it
can be omitted if we want to replace only the first ocurrence of a pattern, or
replaced with a number to replace only a certain number of occurrences.
xargs (https://man7.org/linux/man-pages/man1/xargs.1.html)
xargs  lets us apply a command to an output redirected from a pipe. For
instance,  output | xargs command  would apply  command  to  output . Some useful
options:
-n1  tells  xargs  to apply the command to every item in  output  once if output
has multiple items in it (such as a list of multiple strings)
-0  tells  xargs  to split items in the output by the null character, which
signifies the end of a string, instead of using spaces. Paired with  -n1 , this
means  xargs  will apply a command to every string, instead of breaking up
strings into individual words and applying the command to every word.

TASKS
Task 1
Using Bash functions and shell wildcard expansion, write a shell script
batchrename.sh  to rename file extensions in a particular directory. Here is some more
specific info about this function:
It should take in 3 arguments: the directory, the original extension, and the
new extension.
It should print the line renaming to for each renamed file.
It should not modify any files in the directory that do not have the specified
extension.
For example:
# Create a new directory tmp and adds 26 new files a.dat, b.dat ... to z.dat into it 
$ mkdir tmp && touch tmp/{a..z}.dat 
# Run your script 
$ ./batchrename.sh tmp dat txt 
renaming tmp/a.dat to tmp/a.txt 
# 25 more lines
# Get the number of lines in ls which contain .txt (should be 26) 
ls -lAh tmp | grep .txt | wc -l

Task 2
Write a shell script  addressbook  which has the following behavior:
./addressbook new <name> <email>  adds an entry to the addressbook. Don’t worry
about duplicates (always add a new entry, even if the name is the same).
./addressbook list  displays every entry in the addressbook (in no particular
order). If the addressbook has no entries, display addressbook is empty
./addressbook remove <name>  deletes all entries associated with that name. Do
nothing if that name is not in the addressbook.
./addressbook clear  deletes the entire addressbook.
./addressbook lookup <name>  displays all email(s) associated with that name.
You can assume all emails are in the form  aaa@aaa.aaa  where  aaa  is any number
of digits or letters. You can print the name as well as the email for each
line. For an additional challenge, try printing all emails without their names.
You can find emails by using regular expressions. Some examples here and here
For example,
$ ./addressbook new "John Doe" a@gmail.com 
$ ./addressbook list 
John Doe a@gmail.com 
$ ./addressbook new "Vasya Pupkin" v@gmail.com 
$ ./addressbook new "John Doe" b@gmail.com 
$ ./addressbook list 
John Doe a@gmail.com 
Vasya Pupkin v@gmail.com 
John Doe b@gmail.com 
# OPTIONAL BEHAVIOR 
$ ./addressbook lookup "John Doe"  
a@gmail.com 
b@gmail.com 
# ALTERNATIVE BEHAVIOR 
$ ./addressbook lookup "John Doe" 
John Doe a@gmail.com 
John Doe b@gmail.com 
$ ./addressbook remove "John Doe" 
$ ./addressbook list 
Vasya Pupkin v@gmail.com 
$ ./addressbook clear 
$ ./addressbook list 
addressbook is empty
If you run into an edge case that isn’t described here, you can handle it however you
wish (or don’t handle it at all). You can assume all inputs are in the correct format.
Hints:
bash  has an append operator  >> , which appends the data from its first
argument to the end of the second argument.
bash  also has a redirect operator  > , which takes the output of one command
and outputs it to a file.
In  bash , changing lines can be done through the  sed ,  cut ,  tr  or  awk
commands.
bash  exposes its command line arguments through the  $<integer>  positional
parameter