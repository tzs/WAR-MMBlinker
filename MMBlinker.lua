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
    LabelSetText("MMBlinker_filtersLabel"..n, L"group");
    MMBlinker.pinList[n] = {}
    MMBlinker.pinList[n].pins = {}
    MMBlinker.pinList[n].pins[1] = SystemData.MapPips.GROUP_MEMBER
    n = n + 1
    LabelSetText("MMBlinker_filtersLabel"..n, L"warband");
    MMBlinker.pinList[n] = {}
    MMBlinker.pinList[n].pins = {}
    MMBlinker.pinList[n].pins[1] = SystemData.MapPips.WARBAND_MEMBER
    n = n + 1
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

function MMBlinker.leftDownFilters(flags,x,y)
    local scale = WindowGetScale("MMBlinker_filters")
    if ( scale ~= 0 ) then
        x = x / scale
        y = y / scale
    end
    local n = math.floor((y-15)/30)+1
    MMBlinker.start(n)
end

function MMBlinker.rightDownFilters()
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

function MMBlinker.allon()
    for index, type in pairs( SystemData.MapPips )
    do
        MapSetPinFilter("EA_Window_OverheadMapMapDisplay", type, true) 
    end
end
