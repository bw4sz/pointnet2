#start a gpu session on hipergator
srun -p gpu --gres=gpu:1 --pty -u bash -i

source activate pointnet2

#load cuda module to compile ops
ml cuda

#doesn't see my packages dir at first, set pythonpath
export PYTHONPATH=/home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages

#find python paths for tensorflow-gpu
#get_include
TF_INC=/home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages/tensorflow/include
TF_LIB=/home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages/tensorflow/

#Compile ops#
#3d tf_interpolate
g++ -std=c++11 tf_ops/3d_interpolation/tf_interpolate.cpp -o tf_ops/3d_interpolation/tf_interpolate_so.so -shared -fPIC -I /home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages/tensorflow/include -I /apps/cuda/9.0.176/include -I /home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages/tensorflow/include/external/nsync/public -lcudart -L /apps/cuda/9.0.176/lib64/ -L /home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages/tensorflow/ -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0


#grouping
nvcc tf_ops/grouping/tf_grouping_g.cu -o tf_ops/grouping/tf_grouping_g.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC
g++ -std=c++11 tf_ops/grouping/tf_grouping.cpp tf_ops/grouping/tf_grouping_g.cu.o -o tf_ops/grouping/tf_grouping_so.so -shared -fPIC -I /home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages/tensorflow/include -I /apps/cuda/9.0.176/include -I /home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages/tensorflow/include/external/nsync/public -lcudart -L /apps/cuda/9.0.176/lib64/ -L /home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages/tensorflow/ -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0

#sampling
nvcc tf_ops/sampling/tf_sampling_g.cu -o tf_ops/sampling/tf_sampling_g.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC

g++ -std=c++11 tf_ops/sampling/tf_sampling.cpp tf_ops/sampling/tf_sampling_g.cu.o -o tf_ops/sampling/tf_sampling_so.so -shared -fPIC -I /home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages/tensorflow/include -I /apps/cuda/9.0.176/include -I /home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages/tensorflow/include/external/nsync/public -lcudart -L /apps/cuda/9.0.176/lib64/ -L /home/b.weinstein/miniconda3/envs/pointnet2/lib/python3.6/site-packages/tensorflow/ -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0
