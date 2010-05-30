<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="MMBlinker" version="1.0" date="2010-05-30">
        <Author name="tzs"/>
        <Description text="Blinks selected pips on mini-map to make then easy to see"/>
        <VersionSettings gameVersion="1.3.5"/>
        <Dependencies>
            <Dependency name="EA_OverheadMapWindow" />
            <Dependency name="EASystem_LayoutEditor" />
        </Dependencies>
        <Files>
            <File name="MMBlinker.lua"/>
            <File name="MMBlinkerIcon.xml"/>
            <File name="MMBlinker.xml"/>
        </Files>
        <OnInitialize>
            <CallFunction name="MMBlinker.initialize"/>
        </OnInitialize>
        <OnUpdate>
            <CallFunction name="MMBlinker.repentHarlequin"/>
        </OnUpdate>
        <OnShutdown/>
    <WARInfo>
    <Categories>
        <Category name="MAP" />
    </Categories>
    </WARInfo>
    </UiMod>
</ModuleFile>
