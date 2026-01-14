# Pictures management
There are different applications to view and edit pictures such as snapshots. Snapshots will be used to illustrate the workflow for some specific tasks, specially for [TryHackMe](tryhackme.com) machines.

1. **Flameshot** to print screen (do a screenshot). This tool helps to do a screenshot, edit it with arrows, squares, crop it as will and to save it immediatly. Simply use the `PrtScn` key.
    * On `xfce` desktop enviroments (like Kali) `PrtScn` uses `gnome-screenshot` by default, so if you don't deactivate it,`PrtScn` will continue to use it.
    * `xfce4-settings-manager` to open settings manager window.
    * Click on **Keyboard.**
    * Go to the `Application Shortcuts` tab.
    * Search for `xfce4-screenshooter`.
    * Select the that shortcut and delete it.
    * If you dont find `xfce4-creenshoter` go directly to `Add` and then type `flameshot gui`.
    * Press the key you want to use for screenshots (PrtScn).
    * Close `xfce4 settings manager`.
    * Now every time you press `PrtScn` it will take a snapshot and will open **Flameshot** with its features.   

2. **Drawing** a light picture-image editor. You can acces to this tool from `ristretto` or directly from the terminal. It is light and easy, but it does lack of arrows and transparent squares which ara very usefull. It does have filled squares.

3. **Gimp** is a more complete image editor. It does have a lot of functions. Just like *Drawing* you can access to this tool from `ristretto` or directly from the terminal. It is a little bit complex but it does have transparent squares on which you can add strokes to highlight an important area. You can draw arrows with the brush tool manually.

---

When you use the GUI and open an image it will open automatically in `ristretto`, this is the default image view application.

Thanks for reading.
- Roberto Orozco