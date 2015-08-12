#!/usr/bin/python

# gtk module
import gtk

# matplotlib Figure object
from matplotlib.figure import Figure
# numpy functions for image creation
import numpy as np

# import the GtkAgg FigureCanvas object, that binds Figure to
# GTKAgg backend. In this case, this is a gtk.DrawingArea
from matplotlib.backends.backend_gtkagg import FigureCanvasGTKAgg as FigureCanvas

# instantiate the GTK+ window object
win = gtk.Window()
# connect the 'destroy' signal to gtk.main_quit function
win.connect("destroy", gtk.main_quit)
# define the size of the GTK+ window
win.set_default_size(600, 400)
# set the window title
win.set_title("Matplotlib Figure in a GTK+ Window")

# matplotlib code to generate the plot
fig = Figure(figsize=(5, 4), dpi=100)
ax = fig.add_subplot(111)
x = np.arange(0,2*np.pi,.01)
y = np.sin(x**2)*np.exp(-x)
ax.plot(x, y)

# we bind the figure to the FigureCanvas, so that it will be
# drawn using the specific backend graphic functions
canvas = FigureCanvas(fig)
# add that widget to the GTK+ main window
win.add(canvas)

# show all the widget attached to the main window
win.show_all()
# start the GTK+ main loop
gtk.main()
