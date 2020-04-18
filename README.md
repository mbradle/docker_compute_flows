# docker_compute_flows
This is the Webnucleo network flow computer docker image repository.

# Steps to build and run the default docker image.

First clone the repository.  Type:

**git clone http://github.com/mbradle/docker_compute_flows**

Now change into the cloned directory.  Type:

**cd docker_compute_flows**

If you have previously cloned the repository, you can update by typing:

**git pull**

Now build the image.  Type:

**docker build -t flow_computer:default .**

The docker image that gets built is *flow_computer:default*.  The *:default* is a tag that allows you to distinguish other flow computer images.  Of course you can provide your own name for both the image and the tag.

Now create a directory for the input.  Type:

**mkdir work**

**mkdir work/input**

**cp input/run.rsp work/input/**

Now get the data file from which you will compute the flows.  This could be, for example, the output from running a [single_zone docker](https://github.com/mbradle/docker_single_zone/blob/master/README.md) container. Place the xml file you will use in the *work/input* directory with the name *input.xml*.  For example, copy the *docker_single_zone/work/output/out.xml* you obtained from the single-zone docker container you built to *work/input/input.xml* in *docker_compute_flows*.

Now note the answer to typing

**pwd**

In the instructions below, you should simply be able to use the commands verbatim (most likely, you will simply cut and paste).  If that does not work, replace the *${PWD}* present with the string that is returned by the *pwd* command.

Now edit *work/input/run.rsp*.  Run the calculation.  For example, type:

**docker run -it -v ${PWD}/work/input:/input_directory -e VAR=@/input_directory/run.rsp flow_computer:default**

This will print out the flows for the chosen options in your response file.
You can redirect the output to a file by typing:

**docker run -it -v ${PWD}/work/input:/input_directory -e VAR=@/input_directory/run.rsp flow_computer:default > flows.txt**

In this case, the file flows.txt will contain the flows.

If you want to combine the individual files into a single file (and remove all the individual files), use the *OUT_FILE* variable.  For example, type:

**sudo docker run -it -v ${PWD}/work/input:/input_directory -e VAR=@/input_directory/run.rsp flow_computer:default > flows.txt**

Here are some [notes](https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo) on running without *sudo* that may be of interest.

# Steps to list possible options or an example execution.

To get a help statement for a flow computer docker image, type:

**docker run -e VAR=--help flow_computer:default**

The output lists a usage statement for the underlying network computer flow code.  Any of the suggested commands can be entered as input through the *VAR* variable.  For example, you can type:

**docker run -e VAR=--example flow_computer:default**

to get the example execution (of the underlying network flows computer code).  The options in the example execution would be added to the response file or the command line (through *VAR*).  To get the listing of all possible options, type:

**docker run -e VAR="--prog all" flow_computer:default**

The input to *VAR* is between quotes to ensure that it is recognized as a single input string.  To get options for a particular class, select that class as input to the *program_options* option.  For example, type:

**docker run -e VAR="--prog flow_computer" flow_computer:default**

# Steps to build with a different master.h file.

First, it's useful to prune any dangling containers by typing:

**docker system prune**

The command

**docker system prune -a**

will clear out everything and start over if you prefer.

Next, download the default *master.h* to the *$PWD* directory.  Type:

**docker run -it -v ${PWD}:/header_directory -e HEADER_COPY_DIRECTORY=/header_directory flow_computer:default**

Edit *master.h*.  Now rebuild, but set the WN_USER flag:

**docker build -t flow_computer:tag --build-arg WN_USER=1 .**

where *tag* is a tag to distinguish the new image from the default.  

# How to force a rebuild of one of your images.

If you suspect that the underlying code has been updated since your latest docker build, you can force a rebuild by using the *--no-cache* option.  For example, you can type:

**docker build --no-cache -t flow_computer:default .**

This will force docker to pull any new changes to the underlying codes down before rebuilding.

# Using Docker Hub for your images.

Once you have an image that you would like to share with your collaborators, you can set up a repository on [Docker Hub](https://hub.docker.com).  You can push images to the repository that others can then pull down and use.  This [site](https://runnable.com/docker/using-docker-hub) provides more information.
