MiniMap Blinker places a small icon of a green cross below the map filters
button (you can move this from the layout editor if you wish). If you left
click the icon, it will hide all the pips on the mini map except for the
one for the NPC Healer and for you. These two pips will blink to make them
easy to pick out against the background.

Left Click the icon again to stop the blinking. It will stop on its own
after 30 seconds. All pips the MiniMap Blinker hid will be restored.

If you right click the icon, a list will pop up listing the categories of
mini map pips, similar to the those in the map filter window. Left
clicking on an item in this list will hide all pips except for the type
and the one representing you, and will blink them, just as described above
for the Healer pip. Left clicking on that item again while the blinking
is in progress will stop it. Clicking on a different item will stop the
blinking of the first and switch to the second.

The pop up list includes the same options that the map filter list
includes, plus two extra items:

    "group" blinks your group members, and

    "warband" blinks those in your warband that are NOT in
    your group.

When the pop up listing is open, any click on the icon will stop the
blinking and close the pop up. Right clicking will also close the
pop up, but without stopping blinking that is in progress (you can
always left click the icon to stop it, or wait for the 30 second
auto stop)

NOTE: if you find that you are often using the pop up to blink a
particular item, you can make a macro to start and stop that item.
First, find the number of the item in the drop down list. The first
item is #1, the second is #2, and so on. Then make this macro:

    /script MMBlinker.start(N)

where N is the number of the item. Invoking that macro will start
that item's pips blinking. Invoking it while the item is blinking
will stop the blinking.

Although named "MiniMap Blinker", it actually also blinks the pips
on the main map.
