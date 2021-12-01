FROM amazon/aws-lambda-python:3.8

# optional : ensure that pip is up to data
RUN /var/lang/bin/python3.8 -m pip install --upgrade pip

# install essential library
RUN yum install python3-dev python3-setuptools gcc libtinfo-dev zlib1g-dev build-essential cmake libedit-dev libxml2-dev git -y
# git clone
RUN git clone https://github.com/manchann/TVM_Lambda_Container.git

# install packages
RUN pip install --user -r TVM_Lambda_Container/requirements.txt

WORKDIR TVM_Lambda_Container/tvm
RUN mkdir build && cmake/config.cmake build

RUN export TVM_HOME=~/TVM_Lambda_Container/tvm
RUN export PYTHONPATH=$TVM_HOME/python:${PYTHONPATH}



CMD ["lambda_function.lambda_handler"]
