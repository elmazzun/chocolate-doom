# Some notes of mine useful for dev

Accommodating the need to run on different operating systems was challenging.
The solution was to have a common "core" that was platform agnostic.
To perform I/O, the core would tap into sub-systems specific to the platform
they targeted.
Most of the DOOM code is shared. Only a few files are platform specific.
Since C has no namespaces, prefixes are applied to function names.
I_ stands for "implementation-specific", P_ gameplay, R_ is for renderer and so on.
The beauty of this architecture is that once the platform-specific systems are
written, there is zero overhead to writing code that runs on multiple platforms.
Most of the code goes into the core and the platform-specific code needs not be
touched any more.
Because portability was not an afterthought but an integral part of the
development process, DOOM’s code layering is never violated. This rigorous
design partly explains why DOOM has been ported to so many systems: there is
very little code to write.

Start divig into the code: where the frick is the `main`?
In the case of DOOM there is one entry point per OS and they are all in
implementation-specific (I_*) files. Regardless of the platform, all entry
points converge on the core main function named `D_DoomMain` located in d_main.c.

```c
void D_DoomMain(void) {
    FindResponseFile(); // Search doom . wad , doom1 . wad ...
    IdentifyVersion();  // shareware or registered ?
    V_Init();           // Video system
    M_LoadDefaults();   // Load params from default . cfg
    Z_Init();           // Zone Memory Allocator
    M_Init();           // Menu
    R_Init();           // Renderer
    P_Init();           // gamePlay
    I_Init();           // Implementation dependant
    D_CheckNetGame();
    S_Init();           // sound
    HU_Init();          // HUD
    ST_Init();          // Status bar
    D_DoomLoop();     // never returns
} /* d_main . c */
```

Peeking inside `D_DoomLoop` reveals a standard loop where the machine runs as
fast as possible to update the game simulation according to user input and
A.I., and then generate visual and audio output.

```c
void D_DoomLoop(void)
{
    if (gamevariant == bfgedition &&
        (demorecording || (gameaction == ga_playdemo) || netgame))
    {
        printf(" WARNING: You are playing using one of the Doom Classic\n"
               " IWAD files shipped with the Doom 3: BFG Edition. These are\n"
               " known to be incompatible with the regular IWAD files and\n"
               " may cause demos and network games to get out of sync.\n");
    }

    if (demorecording)
        G_BeginRecording();

    main_loop_started = true;

    I_SetWindowTitle(gamedescription);
    I_GraphicsCheckCommandLine();
    I_SetGrabMouseCallback(D_GrabMouseCallback);
    I_InitGraphics();
    EnableLoadingDisk();

    TryRunTics();

    V_RestoreBuffer();
    R_ExecuteSetViewSize();

    D_StartGameLoop();

    if (testcontrols)
    {
        wipegamestate = gamestate;
    }

    while (1)
    {
        D_RunFrame();
    }
}
```

Sono arrivato a pag.264 del libro, quando inizia a parlare dell'AI.

# Useful links:

* doom.fandom.com/wiki/Category:Doom_engine
* doom.fandom.com/wiki/Doom_source_code_files
* doomwiki.org/wiki/Doom_source_code
* doom.fandom.com/wiki/Doom_source_code
* doomwiki.org/wiki/Doom_source_code_functions
* doomwiki.org/wiki/Doom_source_code

# Useful resources

* Game Engine Black Book Doom (by Fabien Sanglard)
