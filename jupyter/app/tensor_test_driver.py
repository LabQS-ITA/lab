import tensorflow as tf

if __name__=="__main__":
    tf.compat.v1.logging.set_verbosity(tf.compat.v1.logging.ERROR)
    print(tf.config.list_physical_devices('GPU'))
