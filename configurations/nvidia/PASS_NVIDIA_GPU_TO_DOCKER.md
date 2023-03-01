# Pass Nvidia GPU to Docker

I'm just going to compile some links that were helpful for right now and I'll try to write a more detailed guide later.

https://www.cyberciti.biz/faq/ubuntu-linux-install-nvidia-driver-latest-proprietary-driver/

https://forums.developer.nvidia.com/t/nvidia-smi-has-failed-because-it-couldnt-communicate-with-the-nvidia-driver-make-sure-that-the-latest-nvidia-driver-is-installed-and-running/197141

Test with `docker run -it --gpus all nvidia/cuda:11.4.0-base-ubuntu20.04 nvidia-smi` and `nvidia-smi`

And then for passing to a container

https://docs.docker.com/compose/gpu-support/
