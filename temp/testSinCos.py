import RPi.GPIO as gpio

gpio.setmode(gpio.BCM)

clk = 10
gpio.setup(clk, gpio.OUT)

data_out_complete = 10
gpio.setup(clk, gpio.IN)

counter = 0

while(1):
    counter = counter + 1
    gpio.output(clk, counter%2)

    if counter%2 == 1:  #meaning at every positive edge
        print(gpio.input(data_out_complete))
