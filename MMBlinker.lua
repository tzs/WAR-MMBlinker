MMBlinker = {}

function MMBlinker.initialize()
    MMBlinker.blink = {
        {true, false, .25},
        {false, true, .25},
        {true, true, .16}
    }
    MMBlinker.filtersShowing = false
    MMBlinker.pinList = {}
    
    CreateWindow("MMBlinker", true)
    WindowSetShowing("MMBlinker", true)
    CreateWindow("MMBlinker_filters", true)
    WindowSetShowing("MMBlinker_filters", false)
    
    local n = 1
    for i, o in pairs(EA_Window_OverheadMap.mapPinFilters) do
        if ( n <= 20 ) then
            LabelSetText("MMBlinker_filtersLabel"..n, GetStringFromTable("MapPointFilterNames", o.label))
            MMBlinker.pinList[n] = o
            n = n + 1
        end
    end
    local x, y = WindowGetDimensions("MMBlinker_filters")
    y = 15 + 30 * n
    WindowSetDimensions("MMBlinker_filters", x, y)
    LayoutEditor.RegisterWindow( "MMBlinker" , L"MMBlinker" , L"MMBlinker Windows",
                               false , false , true , nil )
end

function MMBlinker.leftDownMain()
    if ( MMBlinker.filtersShowing == true or MMBlinker.running == true ) then
        WindowSetShowing("MMBlinker_filters", false)
        MMBlinker.filtersShowing = false
        MMBlinker.running = false
        MMBlinker.blinkState(0)
    else
        MMBlinker.start(0)
    end
end

function MMBlinker.rightDownMain()
    if ( MMBlinker.filtersShowing == true ) then
        WindowSetShowing("MMBlinker_filters", false)
        MMBlinker.filtersShowing = false
    else
        WindowSetShowing("MMBlinker_filters", true)
        MMBlinker.filtersShowing = true
    end
end

function MMBlinker.leftDown(n)
    MMBlinker.start(n)
end

function MMBlinker.rightDown(n)
    MMBlinker.rightDownMain()
end

function MMBlinker.start(n)
    if ( MMBlinker.running ) then
        MMBlinker.blinkState(0)
        if ( MMBlinker.currentPins == n ) then
            return
        end
    end
    for index, type in pairs( SystemData.MapPips )
    do
        MapSetPinFilter("EA_Window_OverheadMapMapDisplay", type, false)
    end
    MMBlinker.pins = {SystemData.MapPips.HEALER_NPC}
    if ( n > 0 ) then
        MMBlinker.pins = MMBlinker.pinList[n].pins
    end
    MMBlinker.currentPins = n
    MMBlinker.autoStop = 30
    MMBlinker.blinkState(1)
end

function MMBlinker.leftDown1() MMBlinker.leftDown(1) end
function MMBlinker.rightDown1() MMBlinker.rightDown(1) end
function MMBlinker.leftDown2() MMBlinker.leftDown(2) end
function MMBlinker.rightDown2() MMBlinker.rightDown(2) end
function MMBlinker.leftDown3() MMBlinker.leftDown(3) end
function MMBlinker.rightDown3() MMBlinker.rightDown(3) end
function MMBlinker.leftDown4() MMBlinker.leftDown(4) end
function MMBlinker.rightDown4() MMBlinker.rightDown(4) end
function MMBlinker.leftDown5() MMBlinker.leftDown(5) end
function MMBlinker.rightDown5() MMBlinker.rightDown(5) end
function MMBlinker.leftDown6() MMBlinker.leftDown(6) end
function MMBlinker.rightDown6() MMBlinker.rightDown(6) end
function MMBlinker.leftDown7() MMBlinker.leftDown(7) end
function MMBlinker.rightDown7() MMBlinker.rightDown(7) end
function MMBlinker.leftDown8() MMBlinker.leftDown(8) end
function MMBlinker.rightDown8() MMBlinker.rightDown(8) end
function MMBlinker.leftDown9() MMBlinker.leftDown(9) end
function MMBlinker.rightDown9() MMBlinker.rightDown(9) end
function MMBlinker.leftDown10() MMBlinker.leftDown(10) end
function MMBlinker.rightDown10() MMBlinker.rightDown(10) end
function MMBlinker.leftDown11() MMBlinker.leftDown(11) end
function MMBlinker.rightDown11() MMBlinker.rightDown(11) end
function MMBlinker.leftDown12() MMBlinker.leftDown(12) end
function MMBlinker.rightDown12() MMBlinker.rightDown(12) end
function MMBlinker.leftDown13() MMBlinker.leftDown(13) end
function MMBlinker.rightDown13() MMBlinker.rightDown(13) end
function MMBlinker.leftDown14() MMBlinker.leftDown(14) end
function MMBlinker.rightDown14() MMBlinker.rightDown(14) end
function MMBlinker.leftDown15() MMBlinker.leftDown(15) end
function MMBlinker.rightDown15() MMBlinker.rightDown(15) end
function MMBlinker.leftDown16() MMBlinker.leftDown(16) end
function MMBlinker.rightDown16() MMBlinker.rightDown(16) end
function MMBlinker.leftDown17() MMBlinker.leftDown(17) end
function MMBlinker.rightDown17() MMBlinker.rightDown(17) end
function MMBlinker.leftDown18() MMBlinker.leftDown(18) end
function MMBlinker.rightDown18() MMBlinker.rightDown(18) end
function MMBlinker.leftDown19() MMBlinker.leftDown(19) end
function MMBlinker.rightDown19() MMBlinker.rightDown(19) end
function MMBlinker.leftDown20() MMBlinker.leftDown(20) end
function MMBlinker.rightDown20() MMBlinker.rightDown(20) end

function MMBlinker.repentHarlequin(elapsed)
    if ( MMBlinker.running == true )
    then
        MMBlinker.autoStop = MMBlinker.autoStop - elapsed
        if ( MMBlinker.autoStop <= 0 ) then
            MMBlinker.blinkState(0)
        else
            MMBlinker.flipTime = MMBlinker.flipTime - elapsed
            if ( MMBlinker.flipTime <= 0 )
            then
                MMBlinker.currentState = MMBlinker.currentState + 1
                if ( MMBlinker.currentState > #MMBlinker.blink ) then
                    MMBlinker.currentState = 1
                end
                MMBlinker.blinkState( MMBlinker.currentState )
            end
        end
    end
end

function MMBlinker.blinkState(n)
    if ( n == 0 ) then
        MMBlinker.running = false
        for index, type in pairs( SystemData.MapPips )
        do
            MapSetPinFilter("EA_Window_OverheadMapMapDisplay", type, EA_Window_OverheadMap.Settings.mapPinFilters[type]) 
        end
    else
        MapSetPinFilter("EA_Window_OverheadMapMapDisplay", SystemData.MapPips.PLAYER, MMBlinker.blink[n][2])
        for i, f in pairs(MMBlinker.pins) do
            MapSetPinFilter("EA_Window_OverheadMapMapDisplay", f, MMBlinker.blink[n][1])
        end
        MMBlinker.flipTime = MMBlinker.blink[n][3]
        MMBlinker.currentState = n
        MMBlinker.running = true
    end
end

function MMBlinker.dp(...)
    local out = L""
    for i, part in ipairs(arg) do
        if ( type(part) == "wstring" ) then
            out = out .. part
        elseif ( type(part) == "boolean" ) then
            if ( part == true ) then out = out .. L"true"
            else out = out .. L"false" end
        else
            out = out .. towstring(""..part)
        end
    end
    d(out)
end
