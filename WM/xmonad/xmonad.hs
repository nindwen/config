import XMonad
import XMonad.Layout.Spacing 
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO
import XMonad.Layout.NoBorders
import XMonad.Layout.Circle

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "feedthebeast" --> doFloat
    , className =? "Steam"     --> doFloat
    ]
main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/lumolk/.xmonad/xmobarrc"
  xmonad $ defaultConfig
    { terminal    = "urxvtc"
    , modMask     = mod4Mask
    , focusFollowsMouse = False
    , borderWidth = 1
                 , normalBorderColor  = "#B8C68C" -- black
                 , focusedBorderColor = "#A0DF5D" -- reddish
    , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#ffffff" "" . shorten 50
			, ppLayout = const "" 
                        }
    ,layoutHook = smartBorders $ avoidStruts( smartSpacing 20 $ Tall 1 (3/100) (1/2))  ||| avoidStruts(Tall 1 (3/100) (1/2) ) ||| Circle ||| Full
    ,manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook defaultConfig
    }

    `additionalKeys`
    [((mod1Mask .|. shiftMask   , xK_b), spawn "firefox")
    ,((mod1Mask             , xK_p), spawn "gmrun")
    ]
