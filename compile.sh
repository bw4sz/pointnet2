#start a gpu session on hipergator
srun -p gpu --gres=gpu:1 --pty -u bash -i

module load tensorflow/1.7.0

#doesn't see my packages dir at first, set pythonpath
export PYTHONPATH=/home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages

#find python paths for tensorflow-gpu
#get_include
TF_INC=/apps/tensorflow/1.7.0.0/venv/lib/python3.6/site-packages/tensorflow/include/
TF_INC=/apps/tensorflow/1.7.0.0/venv/lib/python3.6/site-packages/tensorflow/include
TF_LIB=/apps/tensorflow/1.7.0.0/venv/lib/python3.6/site-packages/tensorflow

#/apps/compilers/cuda/9.1.85

#Compile ops#
#3d tf_interpolate
g++ -std=c++11 tf_ops/3d_interpolation/tf_interpolate.cpp -o tf_ops/3d_interpolation/tf_interpolate_so.so -shared -fPIC -I /apps/tensorflow/1.7.0.0/venv/lib/python3.6/site-packages/tensorflow/include -I /apps/compilers/cuda/9.1.85/include -I /apps/tensorflow/1.7.0.0/venv/lib/python3.6/site-packages/tensorflow/include/external/nsync/public -lcudart -L /apps/compilers/cuda/9.1.85/lib64 -L /apps/tensorflow/1.7.0.0/venv/lib/python3.6/site-packages/tensorflow -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0

#grouping
nvcc tf_ops/grouping/tf_grouping_g.cu -o tf_ops/grouping/tf_grouping_g.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC
g++ -std=c++11 tf_ops/grouping/tf_grouping.cpp tf_ops/grouping/tf_grouping_g.cu.o -o tf_ops/grouping/tf_grouping_so.so -shared -fPIC -I /apps/tensorflow/1.7.0.0/venv/lib/python3.6/site-packages/tensorflow/include -I /apps/compilers/cuda/9.1.85/include -I /apps/tensorflow/1.7.0.0/venv/lib/python3.6/site-packages/tensorflow/include/external/nsync/public -lcudart -L /apps/compilers/cuda/9.1.85/lib64 -L /apps/tensorflow/1.7.0.0/venv/lib/python3.6/site-packages/tensorflow -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0

#sampling
nvcc tf_ops/sampling/tf_sampling_g.cu -o tf_ops/sampling/tf_sampling_g.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC

g++ -std=c++11 tf_ops/sampling/tf_sampling.cpp tf_ops/sampling/tf_sampling_g.cu.o -o tf_ops/sampling/tf_sampling_so.so -shared -fPIC -I /apps/tensorflow/1.7.0.0/venv/lib/python3.6/site-packages/tensorflow/include -I /apps/compilers/cuda/9.1.85/include -I /apps/tensorflow/1.7.0.0/venv/lib/python3.6/site-packages/tensorflow/include/external/nsync/public -lcudart -L /apps/compilers/cuda/9.1.85/lib64 -L /apps/tensorflow/1.7.0.0/venv/lib/python3.6/site-packages/tensorflow -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0
