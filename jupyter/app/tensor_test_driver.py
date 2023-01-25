from tensorflow.python.client import device_lib

if __name__=="__main__":
    print(device_lib.list_local_devices())
