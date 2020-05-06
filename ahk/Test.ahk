else if RegExMatch(chatInput, "i)^\/cfind\b(.*)", var) {
if RegExMatch(var1,"^(\s+|)$") or !RegExMatch(var1,"^ (?:\s+)?(\d+)(?:\s+)?$" , rang) {
addChatMessageEx("AAAAAA" , "/cfind [До какого ранга]")
Exit
}
lastRang := rang1
ArrayNotStreamPlayer := []
ArrayRangs := ["" , "" , "" , "" , "" , "" , "", "" , "" , ""]
SendChat("/find")
sleep 800
while !(isDialogOpen() && getDialogCaption() = "{ffff00}Члены организации онлайн")
continue
Loop
{
if not (string := getDialogLine(A_Index+3))
break
else RegExMatch(string, "\}(\d{1,3}).*\s(\d{1,2})\s+\d\/😔.*)", value)

if (getPlayerSkin(value1) = -1) and (value1 <> getId()) and (value2 <= lastRang)
{
if RegExMatch(value3,"\s+{ffa800}\[AFK: (.*)\]",timeAfk)
timeAfk := ""
else timeAfk := ""
ArrayNotStreamPlayer.Insert([value1,value2,timeAfk])
}
else if (value1 = getId())
myRang := value2
}
SendInput {Enter}
if (ArrayNotStreamPlayer.Length() = 0)
addChatMessageEx("FFFFFF","• {FFC800}[Подсказка] {FFFFFF}Все сотрудники на месте.")
else
{
addChatMessageEx("FFFFFF" , "Отсутствующие cотрудники:")
ArrayOutputForCfind(ArrayNotStreamPlayer,4)
SendChat("/me орлиным взглядом осмотрел всех сотрудников вокруг себя")
sleep 2200
SendChat("/me произвел расчёты, cопоставил данные")
sleep 1500
SendChat("/r Отсутствующие сотрудники:")
sleep 1500
For v, pair in ArrayNotStreamPlayer
{
ArrayRangsFuction(pair[2],ArrayRangs,position)
nickname := getPlayerName(pair[1])
if nickname
{
SendChat(position "/r " RegExReplace(nickname, "_", " ") pair[3])
sleep 1000
}
}
sleep 1000
SendChat("/r Ваше местоположение?")
}
}

ArrayOutputForCfind(Array,step)
{
stepLoop := 0
lengArray := Array.MaxIndex()
Loop
{
if lengArray > %step%
{
Loop % step
{
id := Array[A_Index + stepLoop][1]
outputlist .= getPlayerName(id) " [" id "]. "
}
lengArray := lengArray - step
addchatmessageEx("B8DBB8" , outputlist)
outputlist := ""
}
else
{
Loop % lengArray
{
id := Array[A_Index + stepLoop][1]
outputlist .= getPlayerName(id) " [" id "]. "
}
addchatmessageEx("B8DBB8" , outputlist)
outputlist := ""
break
}
stepLoop := stepLoop + step
}
}ArrayRangsFuction(rang , ArrayRangs , ByRef position)
{
For n, position in ArrayRangs
{
if (rang = n)
{
position := ArrayRangs[A_Index]
break
}
}
}