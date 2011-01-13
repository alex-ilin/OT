@echo off
rem Oberon Templates. Copyright (c) Alexander Iljin, 2011
sed -e "s/$(ModuleName)/ModuleStack/" -e "s/$(Import)/IMPORT Project;/" -e "s/$(ItemType)/Project.Module/" <Stack.ob2
