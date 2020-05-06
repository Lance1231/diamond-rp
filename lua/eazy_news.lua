--[[ 
  ______                  _   _                   
 |  ____|                | \ | |                  
 | |__   __ _ _____   _  |  \| | _____      _____ 
 |  __| / _` |_  / | | | | . ` |/ _ \ \ /\ / / __|
 | |___| (_| |/ /| |_| | | |\  |  __/\ V  V /\__ \
 |______\__,_/___|\__, | |_| \_|\___| \_/\_/ |___/
                   __/ |                          
                  |___/                           


            by trefa
            https://www.blast.hk/members/50819/
            https://vk.com/trefa.code
 ]]


local st = {settings = {news = true,auto = 0,cel = 0,cmd = {"ggnews","gnr"},sound = 1,
timer = {x = 200,y = 200, render = false, sp = false,lang = false,mad = {style = 0, size = 1, ob = 1, align = 1},direct = {font = "Arial", size = 20, style = 1, align = 1}},
time = {x = 200,y = 200, render = false, sp = false,lang = false,mad = {style = 0, size = 1, ob = 1, align = 1},direct = {font = "Arial", size = 20, style = 1, align = 1}},
gos = {x = 200,y = 200, render = false, sp = false,lang = false,mad = {style = 0, size = 1, ob = 1, align = 1},direct = {font = "Arial", size = 20, style = 1, align = 1}},
}
,gnews = {},news = {}}

local memory = require "memory"
local status, mad = pcall(require,'MoonAdditions')
local flag = require("moonloader").font_flag
local align = {{"Центр","CENTER"},{"Лево","LEFT"},{"Право","RIGHT"}}
local style_d = {"BOLD","ITALICS","BORDER","SHADOW","UNDERLINE","STRIKEOUT",{"BOLD","ITALICS"},{"BOLD","BORDER"},{"BOLD","SHADOW"},{"BOLD","UNDERLINE"},{"BOLD","STRIKEOUT"},{"ITALICS","BORDER"},{"ITALICS","SHADOW"},{"ITALICS","UNDERLINE"},{"ITALICS","STRIKEOUT"},{"BORDER","SHADOW"},{"BORDER","UNDERLINE"},{"BORDER","STRIKEOUT"},{"SHADOW","UNDERLINE"},{"UNDERLINE","STRIKEOUT"}}
local style_m = {"GOTHIC","SUBTITLES","MENU","PRICEDOWN"}
local auto_name = {"{ff2f00}Выключено","{d07aff}Только однострочная","{d07aff}Только трехстрочная","{d07aff}Все новости"}
local render = {"MoonAdditions","DirectX"}
local mes_rus = {{{"Января","Февраля","Марта","Апреля","Майя","Июня","Июля","Августа","Сентября","Октября","Ноября","Декабря"},{"•®ўap¬","Ѓeўpaћ¬","Map¦a","AЈpeћ¬","Maќ¬","…«®¬","…«ћ¬","Aў™yc¦a","Ce®¦¬—p¬","Ok¦¬—p¬","Ho¬—p¬","ѓeka—p¬"}},{{"January","February","March","April","May","June","July","August","September","October","November","December"},{"January","February","March","April","May","June","July","August","September","October","November","December"}}}
local dayr = {{{"Сегодня","Завтра","Послезавтра"},{"Ce™oљ®¬","€aў¦pa","Њocћeџaў¦pa"}},{{"Today","Tomorrow","Day after tomorrow"},{"Today","Tomorrow","Day_after_tomorrow"}}}
local sound = {1052,1053,1054,1055,1056,1057,1058,1083,1084,1085,1137,1138,1139,1149,1150,1190,17802,17803,17006}
local text_r = {{{"Новостей {ff0000}нет","До подачи следующей новости:","больше дня"," год","Очередь пуста","Неизвестно"," в "},{"Hoўoc¦eќ_~r~®e¦","ѓo_Јoљa¤њ_cћeљy«Ўeќ_®oўoc¦њ:","—oћ©Ґe_љ®¬","_™oљ","O¤epeљ©_Јyc¦a","Heњџўec¦®o","_ў_"}},{{"{ff0000}No{ffffff} news","Time before submitting the news: ","more than a day"," year","Queue is empty","Unknown"," at "},{"~r~No~w~_news","Time_before_submitting_the_news:_~p~","more_than_a_day","_year","Queue_is_empty","Unknown","_at_"}}}
local mode = 0
local gn = 0
local nt = false
local ob = false
local mf = 0
local tm = 0
local nm = false
local last_gnews = ""
local lock = false
local time = {0,100,200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000}
local buff_gnews = {}
local pos = 0
local ren = {"timer","time","gos"}
local modes = {
    [0] = {title = "Показывать время до подачи новости", titles = "Рендер времени до подачи новости", name = "timer"},
    [1] = {title = "Показывать текущее время",           titles = "Рендер текущего времени",          name = "time"},
    [2] = {title = "Показывать очередь гос. новостей",   titles = "Рендер очереди гос. новостей",     name = "gos"}
}

local r_dialog = {}

dialog = {
    main = {
        settings = {title = "Eazy News" ,style = 5 ,btn1 = "Далее" ,btn2 = "Закрыть" ,forward =  "{ffffff}" ,backwards = "\n" ,score = false},
        {
            text = "Тип новости\tНазвание",
            mode = function()
                local txt = {}
                for i, val in ipairs(st.gnews) do
                    table.insert(txt, "{d07aff}"..(#val[2] > 1 and "Трехстрочная" or "Однострочная").."\t"..val[1])
                end
                return (#st.gnews < 1 and {"{ff0000}Список гос. новостей пуст\t "} or txt)
            end,
            {
                click = function(button, list, input , outs)
                    return select_button(button, function()
                        gn = list + 1
                        return (#st.gnews < 1 and true or dialog.gnews.news[(#st.gnews[list + 1][2] > 1 and 2 or 1)]) end
                        , false, (list + 1))
                end
            }
        },
        {
            {
                title =  "  ",
                click = function(button, list, input , outs)
                    return select_button(button,true, false)
                end
            },
            {
                title = "{cecece}Очередь гос. новостей",
                click = function(button, list, input , outs)
                    return select_button(button,function()
                        nt = false
                        return func.turn_enable()
                    end, false)
                end
            },
            {
                title = "{00ff45}Создать гос. новость",
                click = function(button, list, input , outs)
                    return select_button(button,dialog.add[1], false)
                end
            },
            {
                title =  "{88a6dd}Настройки",
                click = function(button, list, input , outs)
                    return select_button(button,dialog.settings[1], false)
                end
            }
        }
    },
    turn = {
        no = {
            settings = {title = "Очередь гос. новостей" ,style = 0 ,btn1 = function() return (nt and "Закрыть" or "Назад") end,forward =  "{ff0000}" ,backwards = "\n" ,score = false},
            {
                text = "{ffffff}Очередь гос. новостей пуста",
                {
                    click = function(button, list)
                        return select_button(button, (not nt and dialog.main), false)
                    end
                }
            }
        },
        yes = {
            settings = {title = "Очередь гос. новостей" ,style = 5 ,btn1 = "Далее" ,btn2 = function() return (nt and "Закрыть" or "Назад") end ,forward =  "{ffffff}" ,backwards = "\n" ,score = false}, -- Описание Титла,Стиля,Кнопок диалога
            {
                text = "№\tТип новости\tНазвание\tВремя",
                mode = function()
                    local txt = {}
                    for i, val in ipairs(st.news) do
                        table.insert(txt, "{cecece}"..i.."\t{d07aff}"..(#val[2][2] > 1 and "Трехстрочная" or "Однострочная").."\t"..val[2][1].."\t{cecece}"..os.date("%d/%m/%Y %H:%M:%S",val[1]))
                    end
                    return txt
                end,
                {
                    click = function(button, list, input , outs)
                        return select_button(button, function()
                            mf = list + 1
                            return dialog.turn.delete
                        end, (not nt and dialog.main))
                    end
                }
            }
        },
        delete = {
            settings = {title = "Очередь гос. новостей" ,style = 0 ,btn1 = "{ff0000}Удалить",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
            {
                text = function() local param = func.get_param() return "{cecece}Новость: "..st.news[mf][2][1].."\n{cecece}Время подачи новости: "..os.date("%d/%m/%Y %H:%M:%S",st.news[mf][1]).."\n  \n".."{4465cc}[Гос.Новости] "..param[2].."["..param[1].."]: "..st.news[mf][2][2][1]..(#st.news[mf][2][2] > 1 and "\n[Гос.Новости] "..param[2].."["..param[1].."]: "..st.news[mf][2][2][2].."\n[Гос.Новости] "..param[2].."["..param[1].."]: "..st.news[mf][2][2][3] or "") end,
                {
                    click = function(button, list)
                        return select_button(button, function()
                            table.remove(st.news,mf)
                            update_table()
                            func.SaveJson(st, "moonloader/eazy_news.json")
                            return func.turn_enable()
                        end, dialog.turn.yes)
                    end
                }
            }
        }
    },
    gnews = {
            news = {
                {
                    settings = {title = function() return st.gnews[gn][1] end ,style = 4 ,btn1 = "Далее" ,btn2 = "Назад" ,forward =  "{ffffff}" ,backwards = "\n" ,score = false},
                    {
                        {
                            title = {"{d07aff}Подать гос. новость.","\t"},
                            click = function(button, list)--nm
                                return select_button(button,function()
                                    nm = false
                                    return dialog.gnews.to_lodge
                                end,dialog.main)
                            end
                        },
                        {
                            title = {"(текст строки)","\t{4465cc}"},
                            titles = function() return st.gnews[gn][2][1] end,
                            click = function(button, list)
                                setClipboardText(st.gnews[gn][2][1])
                                sampAddChatMessage("Текущее значение строки скопировано.", 0xcececece)
                                return select_button(button,dialog.gnews.string,dialog.main, 1)
                            end
                        },
                        {
                            title = " ",
                            click = function(button, list)
                                return select_button(button,true,dialog.main)
                            end
                        },
                        {
                            title = "{576dc1}Добавить в очередь гос. новостей\t",
                            click = function(button, list)
                                return select_button(button,dialog.gnews.time_to[1],dialog.main)
                            end
                        },
                        {
                            title = "{dbb13d}Переименовать гос. новость\t",
                            click = function(button, list)
                                setClipboardText(st.gnews[gn][1])
                                sampAddChatMessage("Текущее наименование гос. новости скопировано.", 0xcececece)
                                return select_button(button,dialog.gnews.rename,dialog.main)
                            end
                        },
                        {
                            title = "{ff0000}Удалить гос. новость\t",
                            click = function(button, list)
                                return select_button(button,dialog.gnews.delete,dialog.main)
                            end
                        }
                    }
                },
                {
                    settings = {title = function() return st.gnews[gn][1] end ,style = 4 ,btn1 = "Далее" ,btn2 = "Назад" ,forward =  "{ffffff}" ,backwards = "\n" ,score = false},
                    {
                        {
                            title = {"{d07aff}Подать гос. новость.","\t"},
                            click = function(button, list)--nm
                                return select_button(button,function()
                                    nm = false
                                    return dialog.gnews.to_lodge
                                end,dialog.main)
                            end
                        },
                        {
                            title = {"(текст строки)","\t{4465cc}"},
                            titles = function() return st.gnews[gn][2][1] end,
                            click = function(button, list)
                                setClipboardText(st.gnews[gn][2][1])
                                sampAddChatMessage("Текущее значение строки скопировано.", 0xcececece)
                                return select_button(button,dialog.gnews.string,dialog.main, 1)
                            end
                        },
                        {
                            title = {"(текст строки)","\t{4465cc}"},
                            titles = function() return st.gnews[gn][2][2] end,
                            click = function(button, list)
                                setClipboardText(st.gnews[gn][2][2])
                                sampAddChatMessage("Текущее значение строки скопировано.", 0xcececece)
                                return select_button(button,dialog.gnews.string,dialog.main, 2)
                            end
                        },
                        {
                            title = {"(текст строки)","\t{4465cc}"},
                            titles = function() return st.gnews[gn][2][3] end,
                            click = function(button, list)
                                setClipboardText(st.gnews[gn][2][3])
                                sampAddChatMessage("Текущее значение строки скопировано.", 0xcececece)
                                return select_button(button,dialog.gnews.string,dialog.main, 3)
                            end
                        },
                        {
                            title = " ",
                            click = function(button, list)
                                return select_button(button,true,dialog.main)
                            end
                        },
                        {
                            title = "{576dc1}Добавить в очередь гос. новостей\t",
                            click = function(button, list)
                                return select_button(button,dialog.gnews.time_to[1],dialog.main)
                            end
                        },
                        {
                            title = "{bbf7a2}Время задержки между строками\t",
                            titles = function() return "{d07aff}"..dialog.gnews.time[1].mode[st.gnews[gn][3] + 1]..((st.gnews[gn][3] + 1) ~= 1 and " с" or "") end,
                            click = function(button, list)
                                set_enable(dialog.gnews.time[1].mode,"{d07aff}",st.gnews[gn][3] + 1)
                                return select_button(button,dialog.gnews.time,dialog.main)
                            end
                        },
                        {
                            title = "{dbb13d}Переименовать гос. новость\t",
                            click = function(button, list)
                                setClipboardText(st.gnews[gn][1])
                                sampAddChatMessage("Текущее наименование гос. новости скопировано.", 0xcececece)
                                return select_button(button,dialog.gnews.rename,dialog.main)
                            end
                        },
                        {
                            title = "{ff0000}Удалить гос. новость\t",
                            click = function(button, list)
                                return select_button(button,dialog.gnews.delete,dialog.main)
                            end
                        }
                    }
                }
            },
            time = {
                settings = {title = "Время задержки между строками" ,style = 2 ,btn1 = "Выбрать",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                {
                    mode = {"Нет задержки","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1.0","1.1","1.2","1.3","1.4","1.5","1.6","1.7","1.8","1.9","2.0"},
                    {
                        click = function(button, list)
                            return select_button(button,function()
                                set_enable(dialog.gnews.time[1].mode,"{d07aff}",list + 1)
                                st.gnews[gn][3] = list
                                func.SaveJson(st, "moonloader/eazy_news.json")
                                return true
                            end,dialog.gnews.news[(#st.gnews[gn][2] > 1 and 2 or 1)])
                        end
                    }
                }
            },
            time_to = {
                { -- 1
                settings = {title = function() return "Добавить в очередь" end ,style = 5 ,btn1 = "Далее",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                {
                    text = "{ffffff}Когда подать новость\t{ff0000}Число",
                    mode = function()
                        datetime = {
                            year  = 0,
                            month = 0,
                            day   = 0,
                            hour  = 0,
                            min   = 0,
                            sec   = 0
                        };
                        local txt = {}
                        local day = {"Сегодня","Завтра","Послезавтра"}
                        for i = 0, 2 do
                            local r_time = os.time() + (86400 * i)
                            table.insert(txt,day[i + 1].."\t{cecece}"..os.date("%d",r_time).."/"..os.date("%m",r_time).."/"..os.date("%Y",r_time)) 
                        end
                        r_time = nil
                        return txt
                    end,
                    {
                        click = function(button, list)
                            return select_button(button,function()
                                datetime.year = tonumber(os.date("%Y",os.time() + (86400 * list)))
                                datetime.month = tonumber(os.date("%m",os.time() + (86400 * list)))
                                datetime.day = tonumber(os.date("%d",os.time() + (86400 * list)))
                                return dialog.gnews.time_to[2]
                            end,dialog.gnews.news[(#st.gnews[gn][2] > 1 and 2 or 1)])
                        end
                    }
                }
            },
                { -- 2
                    settings = {title = function() return "Добавить в очередь" end ,style = 5 ,btn1 = "Далее",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        text = "{ffffff}Выберете час подачи новости.",
                        mode = function()
                            local txt = {}
                            hour,day = os.date("%H"),tonumber(os.date("%d"))
                                for i = (datetime.day == day and hour or 0), 23 do
                                    table.insert(txt,(#tostring(datetime.day) == 1 and "0"..tostring(datetime.day) or datetime.day).."/"..(#tostring(datetime.month) == 1 and "0"..tostring(datetime.month) or datetime.month).."/"..datetime.year.." | {e151f7}"..(#tostring(i) == 1 and "0"..tostring(i) or i)) 
                                end
                            return txt
                        end,
                        {
                            click = function(button, list)
                                return select_button(button,function()
                                    datetime.hour = (datetime.day == day and hour or 0) + list
                                    hour,day = nil,nil
                                    return dialog.gnews.time_to[3]
                                end,dialog.gnews.time_to[1])
                            end
                        }
                    }
                },
                { -- 3
                    settings = {title = function() return "Добавить в очередь" end ,style = 5 ,btn1 = "Далее",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        text = "{ffffff}Выберете минуту подачи новости.",
                        mode = function()
                            local txt = {}
                            min,hour = os.date("%M"),tonumber(os.date("%H"))
                                for i = (datetime.hour == hour and min or 0), 59 do
                                    table.insert(txt,(#tostring(datetime.day) == 1 and "0"..tostring(datetime.day) or datetime.day).."/"..(#tostring(datetime.month) == 1 and "0"..tostring(datetime.month) or datetime.month).."/"..datetime.year.." | "..(#tostring(datetime.hour) == 1 and "0"..tostring(datetime.hour) or datetime.hour)..":{e151f7}"..(#tostring(i) == 1 and "0"..tostring(i) or i)) 
                                end
                            return txt
                        end,
                        {
                            click = function(button, list)
                                return select_button(button,function()
                                    datetime.min = (datetime.hour == hour and min or 0) + list
                                    min,hour = nil,nil
                                    return dialog.gnews.time_to[4]
                                end,dialog.gnews.time_to[2])
                            end
                        }
                    }
                },
                { -- 4
                    settings = {title = function() return "Добавить в очередь" end ,style = 5 ,btn1 = "Далее",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        text = "{ffffff}Выберете секунду подачи новости.",
                        mode = function()
                            sec,min = tonumber(os.date("%S")),tonumber(os.date("%M"))
                            local txt = {}
                                for i = (datetime.min == min and sec or 0), 59 do
                                    table.insert(txt,(#tostring(datetime.day) == 1 and "0"..tostring(datetime.day) or datetime.day).."/"..(#tostring(datetime.month) == 1 and "0"..tostring(datetime.month) or datetime.month).."/"..datetime.year.." | "..(#tostring(datetime.hour) == 1 and "0"..tostring(datetime.hour) or datetime.hour)..":"..(#tostring(datetime.min) == 1 and "0"..tostring(datetime.min) or datetime.min)..":{e151f7}"..(#tostring(i) == 1 and "0"..tostring(i) or i)) 
                                end
                            return txt
                        end,
                        {
                            click = function(button, list)
                                return select_button(button,function()
                                    datetime.sec = (datetime.min == min and sec or 0) + list
                                    sec,min = nil,nil
                                    if os.time(datetime) - 10 <= os.time() then
                                        sampAddChatMessage("Введённое время уже прошло введите новое.",0xcececece)
                                        return dialog.gnews.time_to[1]
                                    else
                                        table.insert(st.news,{os.time(datetime),st.gnews[gn]})
                                        func.SaveJson(st, "moonloader/eazy_news.json")
                                        update_table()
                                        sampAddChatMessage("Новость добавлена в очередь.",0xcececece)
                                        return dialog.main
                                    end
                                end,dialog.gnews.time_to[3])
                            end
                        }
                    }
                }
            },
            delete = {
                settings = {title = function() return "Удаление новости" end ,style = 0 ,btn1 = "{ff0000}Удалить",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                {
                    text = "{ffffff}Удалить гос. новость?",
                    {
                        click = function(button, list)
                            return select_button(button,function()
                                table.remove(st.gnews,gn)
                                func.SaveJson(st, "moonloader/eazy_news.json")
                                return dialog.main
                            end,dialog.gnews.news[(#st.gnews[gn][2] > 1 and 2 or 1)])
                        end
                    }
                }
            },
            rename = {
                settings = {title = function() return "Переименование новости" end ,style = 1 ,btn1 = "Переименовать",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                {
                    text = "{ffffff}Укажите новое название гос. новости.",
                        {
                            click = function(button, list, input)
                                return select_button(button,function()
                                    if tostring(input) ~= "" then
                                        st.gnews[gn][1] = tostring(input)
                                        func.SaveJson(st, "moonloader/eazy_news.json")
                                        return dialog.gnews.news[(#st.gnews[gn][2] > 1 and 2 or 1)]
                                    else
                                        sampAddChatMessage("Вы ничего не ввели.", 0xcececece)
                                        return true
                                    end
                                end,dialog.gnews.news[(#st.gnews[gn][2] > 1 and 2 or 1)])
                            end
                        }
                }
            },
            string = { 
                settings = {title = function() return "Изменение строки" end ,style = 1 ,btn1 = "Изменить",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                {
                    text = "{ffffff}Введите текст строки.                                                                                                                                        ",
                        {
                            click = function(button, list, input, outs)
                                return select_button(button,function()
                                    if tostring(input) ~= "" then
                                        if func.len(tostring(input)) <= 72 then
                                            st.gnews[gn][2][outs] = tostring(input)
                                            func.SaveJson(st, "moonloader/eazy_news.json")
                                            return dialog.gnews.news[(#st.gnews[gn][2] > 1 and 2 or 1)]
                                        else
                                            sampAddChatMessage("Строка гос. новости не может превышать 72 символов!", 0xcececece)
                                            setClipboardText(tostring(input))
                                            sampAddChatMessage("Текущее значение строки скопировано.", 0xcececece)
                                            return true
                                        end
                                    else
                                        sampAddChatMessage("Вы ничего не ввели.", 0xcececece)
                                        return true
                                    end
                                end,dialog.gnews.news[(#st.gnews[gn][2] > 1 and 2 or 1)], outs)
                            end
                        }
                }
            },
            to_lodge = {
                settings = {title = function() return (nm and "Подать новость?" or "Подача новости") end ,style = 0 ,btn1 = function() return (nm and "Да" or "Подать") end,btn2 = function() return (nm and "Нет" or "Назад") end,forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                {
                    text = function()
                        local param = func.get_param()
                        return "{cecece}Новость: "..(nm and buff_gnews[2][1] or st.gnews[gn][1]).."\n  \n".."{4465cc}[Гос.Новости] "..param[2].."["..param[1].."]: "..(nm and buff_gnews[2][2][1] or st.gnews[gn][2][1])..((nm and #buff_gnews[2][2] or #st.gnews[gn][2]) > 1 and "\n[Гос.Новости] "..param[2].."["..param[1].."]: "..(nm and buff_gnews[2][2][2] or st.gnews[gn][2][2]).."\n[Гос.Новости] "..param[2].."["..param[1].."]: "..(nm and buff_gnews[2][2][3] or st.gnews[gn][2][3]) or "")..(func.auto_enable((nm and buff_gnews[2][2] or st.gnews[gn][2])) and "\n  \n{ff0000}Будет сделан скриншот!" or "")
                    end,
                    {
                        click = function(button, list)
                            return select_button(button, function()
                                lua_thread.create(to_lodge, (nm and buff_gnews[2] or st.gnews[gn]))
                                buff_gnews = {}
                                return false
                            end, (not nm and dialog.gnews.news[(#st.gnews[gn][2] > 1 and 2 or 1)]))
                        end
                    }
                }
            }
    },
    add = {
            {
                settings = {title = "Создание гос. новости" ,style = 2 ,btn1 = "Выбрать",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                {
                    mode = {"Однострочная","Трёхстрочная"},
                    {
                        click = function(button, list)
                            return select_button(button,dialog.add[2],dialog.main,list + 1)
                        end
                    }
                }
            },
            {
                settings = {title = "Создание гос. новости" ,style = 1 ,btn1 = "Далее",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                {
                    text = "{ffffff}Укажите название гос. новости.",
                        {
                            click = function(button, list, input , outs)
                                return select_button(button,function()
                                    if tostring(input) ~= "" then
                                        table.insert(st.gnews,(outs == 1 and {tostring(input),{"Первая строка"}} or {tostring(input),{"Первая строка","Вторая строка","Третья строка"},0})) -- Добавляем в общую таблицу описание диалогов, зависит от выбора в первом диалоге (Однострочная или Трёхстрочная)
                                        gn = #st.gnews
                                        func.SaveJson(st, "moonloader/eazy_news.json")
                                        return dialog.gnews.news[(#st.gnews[#st.gnews][2] > 1 and 2 or 1)]
                                    else
                                        sampAddChatMessage("Вы ничего не ввели.", 0xcececece)
                                        return true
                                    end
                                end,dialog.add[1], outs)
                            end
                        }
                }
            }
    },
    settings = {
                {
                    settings = {title = "Настройки" ,style = 5 ,btn1 = "Далее",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        text = "Настройка\tПараметр",
                        {
                            title = {"Автоматически скринить при подаче новости","\t"},
                            titles = function() return auto_name[st.settings.auto + 1] end,
                            click = function(button, list)
                                return select_button(button,function()
                                    set_enable(dialog.settings[2][1].mode,"{d07aff}",st.settings.auto + 1)
                                    return dialog.settings[2]
                                end,dialog.main)
                            end
                        },
                        {
                            title = {"Двойное подтверждение новости при отправки с чата","\t"},
                            titles = function() return (st.settings.news and "{488d0c}Включено" or "{ff2f00}Выключено") end,
                            click = function(button, list)
                                return select_button(button,function()
                                    st.settings.news = not st.settings.news
                                    func.SaveJson(st, "moonloader/eazy_news.json")
                                    return true
                                end,dialog.main)
                            end
                        },
                        {
                            title = {"Звуковое оповещение об гос. новости","\t"},
                            titles = function() return (st.settings.sound == 0 and "{ff2f00}" or "{d07aff}")..""..dialog.settings[10][1].mode[st.settings.sound + 1]:gsub("{.+}","") end,
                            click = function(button, list)
                                return select_button(button,function()
                                    set_enable(dialog.settings[10][1].mode,"{d07aff}",st.settings.sound + 1)
                                    return dialog.settings[10]
                                end,dialog.main)
                            end
                        },
                        {
                            title = {"Показывать время до подачи новости","\t"},
                            titles = function() return (st.settings.timer.render and "{488d0c}Включено" or "{ff2f00}Выключено") end,
                            click = function(button, list)
                                mode = 0
                                return select_button(button,dialog.settings[3],dialog.main)
                            end
                        },
                        {
                            title = {"Показывать текущее время","\t"},
                            titles = function() return (st.settings.time.render and "{488d0c}Включено" or "{ff2f00}Выключено") end,
                            click = function(button, list)
                                mode = 1
                                return select_button(button,dialog.settings[3],dialog.main)
                            end
                        },
                        {
                            title = {"Показывать очередь гос. новостей","\t"},
                            titles = function() return (st.settings.gos.render and "{488d0c}Включено" or "{ff2f00}Выключено") end,
                            click = function(button, list)
                                mode = 2
                                return select_button(button,dialog.settings[3],dialog.main)
                            end
                        },
                        {
                            title = {"Команда для вызова основного окна","\t"},
                            titles = function() return "{d07aff}/"..st.settings.cmd[1] end,
                            click = function(button, list)
                                return select_button(button,dialog.settings[11],dialog.main, 1)
                            end
                        },
                        {
                            title = {"Команда для вызова окна очереди","\t"},
                            titles = function() return "{d07aff}/"..st.settings.cmd[2] end,
                            click = function(button, list)
                                return select_button(button,dialog.settings[11],dialog.main, 2)
                            end
                        }
                    }
                },
                {  -- 2
                    settings = {title = "Автоматически скринить при подаче новости" ,style = 2 ,btn1 = "Выбрать",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        mode = {"Выключено","Только однострочная","Только трехстрочная","Все новости"},
                        {
                            click = function(button, list)
                                return select_button(button,function()
                                    st.settings.auto = list
                                    set_enable(dialog.settings[2][1].mode,"{d07aff}",list + 1)
                                    func.SaveJson(st, "moonloader/eazy_news.json")
                                    return true
                                end,dialog.settings[1])
                            end
                        }
                    }
                },
                {  -- 4
                    settings = {title = function() return modes[mode].title end ,style = 4 ,btn1 = "Выбрать",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        {
                            title = "",
                            titles = function() return modes[mode].titles.."\t"..(st.settings[modes[mode].name].render and "{488d0c}Включено" or "{ff2f00}Выключено") end,
                            click = function(button)
                                return select_button(button,function()
                                    st.settings[modes[mode].name].render = not st.settings[modes[mode].name].render
                                    func.SaveJson(st, "moonloader/eazy_news.json")
                                    return true
                                end,dialog.settings[1])
                            end
                        },
                        {
                            title = {"Способ рендера","\t"},
                            titles = function() return "{d07aff}"..render[(st.settings[modes[mode].name].sp and 1 or 2)]  end,
                            click = function(button)
                                return select_button(button,function()
                                    if not status then
                                        st.settings[modes[mode].name].sp = false
                                        sampAddChatMessage("Библиотека MoonAdditions не установлена! Эта функция недоступна.",0xcecece)
                                    else
                                        st.settings[modes[mode].name].sp = not st.settings[modes[mode].name].sp
                                    end
                                    if not st.settings[modes[mode].name].sp then
                                        font = CreateDirectFont()
                                    end
                                    func.SaveJson(st, "moonloader/eazy_news.json")
                                    return true
                                end,dialog.settings[1])
                            end
                        },
                        {
                            title = "Язык\t",
                            titles = function() return (st.settings[modes[mode].name].lang and "{d07aff}Русский" or "{d07aff}Английский")  end,
                            click = function(button)
                                return select_button(button,function()
                                    st.settings[modes[mode].name].lang = not st.settings[modes[mode].name].lang
                                    func.SaveJson(st, "moonloader/eazy_news.json")
                                    return true
                                end,dialog.settings[1])
                            end
                        },
                        {
                            title = "",
                            click = function(button)
                                return select_button(button,true,dialog.settings[1])
                            end
                        },
                        {
                            title = "",
                            titles = function() return (st.settings[modes[mode].name].sp and "Стиль\t{d07aff}"..dialog.settings[4][1].mode[st.settings[modes[mode].name].mad.style + 1] or "Шрифт\t{d07aff}"..st.settings[modes[mode].name].direct.font)  end,
                            click = function(button)
                                return select_button(button,function()
                                    if st.settings[modes[mode].name].sp then
                                        set_enable(dialog.settings[4][1].mode,"{d07aff}",st.settings[modes[mode].name].mad.style + 1)
                                        return dialog.settings[4]
                                    else
                                        return dialog.settings[7]
                                    end
                                end,dialog.settings[1])
                            end
                        },
                        {
                            title = "Размер\t{d07aff}",
                            titles = function() return st.settings[modes[mode].name][(st.settings[modes[mode].name].sp and "mad" or "direct")].size end,
                            click = function(button)
                                return select_button(button,dialog.settings[5],dialog.settings[1])
                            end
                        },
                        {
                            title = "",
                            titles = function() return (st.settings[modes[mode].name].sp and "Размер обводки\t{d07aff}"..st.settings[modes[mode].name].mad.ob or "Стиль\t{d07aff}"..dialog.settings[6][1].mode[st.settings[modes[mode].name].direct.style]) end,
                            click = function(button)
                                return select_button(button,function()
                                    if st.settings[modes[mode].name].sp then
                                        return dialog.settings[9]
                                    else
                                        set_enable(dialog.settings[6][1].mode,"{d07aff}",st.settings[modes[mode].name].direct.style)
                                        return dialog.settings[6]
                                    end
                                end,dialog[2])
                            end
                        },
                        {
                            title = "Выравнивание\t{d07aff}",
                            titles = function() return align[st.settings[modes[mode].name][(st.settings[modes[mode].name].sp and "mad" or "direct")].align][1] end,
                            click = function(button)
                                set_enable(dialog.settings[8][1].mode,"{d07aff}", st.settings[modes[mode].name][(st.settings[modes[mode].name].sp and "mad" or "direct")].align)
                                return select_button(button,dialog.settings[8],dialog.settings[1])
                            end
                        },
                        {
                            title = "Положение\t{d07aff}",
                            titles = function() return st.settings[modes[mode].name].x.."/"..st.settings[modes[mode].name].y end,
                            click = function(button)
                                return select_button(button,function()
                                    pos = mode + 1
                                    sampAddChatMessage("Для сохранения положения два раза нажмите {cecece}ЛКМ{ffffff}.", -1)
                                    showCursor(true, true)
                                    return false
                                end,dialog.settings[1])
                            end
                        }
                    }
                },
                {  -- 4
                    settings = {title = "Стиль" ,style = 2 ,btn1 = "Выбрать",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        mode = {"GOTHIC","SUBTITLES","MENU","PRICEDOWN"},
                        {
                            click = function(button, list)
                                return select_button(button,function()
                                    st.settings[modes[mode].name].mad.style = list
                                    set_enable(dialog.settings[4][1].mode,"{d07aff}",list + 1)
                                    func.SaveJson(st, "moonloader/eazy_news.json")
                                    return true
                                end,dialog.settings[3])
                            end
                        }
                    }
                },
                { -- 5
                    settings = {title = "Размер" ,style = 1 ,btn1 = "Изменить",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        text = "{ffffff}Укажите размер текста.",
                        {
                            click = function(button, list, input , outs)
                                return select_button(button,function()
                                    if tonumber(input) ~= nil then
                                        st.settings[modes[mode].name][(st.settings[modes[mode].name].sp and "mad" or "direct")].size = tonumber(input)
                                        font = CreateDirectFont()
                                        func.SaveJson(st, "moonloader/eazy_news.json")
                                        return dialog.settings[3]
                                    else
                                        sampAddChatMessage("Параметр введён неверно, повторите попытку.", 0xcececece)
                                        return true
                                    end
                                end,dialog.settings[3])
                            end
                        }
                    }
                },
                { -- 6
                    settings = {title = "Стиль" ,style = 4 ,btn1 = "Выбрать" ,btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        mode = {"BOLD","ITALICS","BORDER","SHADOW","UNDERLINE","STRIKEOUT","BOLD + ITALICS","BOLD + BORDER","BOLD + SHADOW","BOLD + UNDERLINE","BOLD + STRIKEOUT","ITALICS + BORDER","ITALICS + SHADOW","ITALICS + UNDERLINE","ITALICS + STRIKEOUT","BORDER + SHADOW","BORDER + UNDERLINE","BORDER + STRIKEOUT","SHADOW + UNDERLINE","UNDERLINE + STRIKEOUT"},
                        {
                            click = function(button, list)
                                return select_button(button,function()
                                    st.settings[modes[mode].name].direct.style = list + 1
                                    set_enable(dialog.settings[6][1].mode,"{d07aff}",list + 1)
                                    font = CreateDirectFont()
                                    func.SaveJson(st, "moonloader/eazy_news.json")
                                    return true
                                end,dialog.settings[3])
                            end
                        }
                    }
                },
                { -- 7
                    settings = {title = "Шрифт" ,style = 1 ,btn1 = "Изменить",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        text = "{ffffff}Укажите название шрифта.",
                        {
                            click = function(button, list, input , outs)
                                return select_button(button,function()
                                    if tostring(input) ~= "" then
                                        st.settings[modes[mode].name].direct.font = tostring(input)
                                        font = CreateDirectFont()
                                        func.SaveJson(st, "moonloader/eazy_news.json")
                                        return dialog.settings[3]
                                    else
                                        sampAddChatMessage("Параметр введён неверно, повторите попытку.", 0xcececece)
                                        return true
                                    end
                                end,dialog.settings[3])
                            end
                        }
                    }
                },
                {  -- 8
                    settings = {title = "Выравнивание" ,style = 2 ,btn1 = "Выбрать",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        mode = {"Центр","Лево","Право"},
                        {
                            click = function(button, list)
                                return select_button(button,function()
                                    st.settings[modes[mode].name][(st.settings[modes[mode].name].sp and "mad" or "direct")].align  = list + 1
                                    set_enable(dialog.settings[8][1].mode,"{d07aff}",list + 1)
                                    func.SaveJson(st, "moonloader/eazy_news.json")
                                    return true
                                end,dialog.settings[3])
                            end
                        }
                    }
                },
                { -- 9
                    settings = {title = "Размер обводки" ,style = 1 ,btn1 = "Изменить",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        text = "{ffffff}Укажите размер  обводки текста.",
                        {
                            click = function(button, list, input , outs)
                                return select_button(button,function()
                                    if tonumber(input) ~= nil then
                                        st.settings[modes[mode].name].mad.ob = tonumber(input)
                                        func.SaveJson(st, "moonloader/eazy_news.json")
                                        return dialog.settings[3]
                                    else
                                        sampAddChatMessage("Параметр введён неверно, повторите попытку.", 0xcececece)
                                        return true
                                    end
                                end,dialog.settings[3])
                            end
                        }
                    }
                },
                {  -- 10
                    settings = {title = "Звуковое оповещение" ,style = 2 ,btn1 = "Выбрать",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        mode = {"Выключено","Звук №1","Звук №2","Звук №3","Звук №4","Звук №5","Звук №6","Звук №7","Звук №8","Звук №9","Звук №10","Звук №11","Звук №12","Звук №13","Звук №14","Звук №15","Звук №16","Звук №17","Звук №18","Звук №19"},
                        {
                            click = function(button, list)
                                return select_button(button,function()
                                    if list > 0 then
                                        EmulRPCPlayerPlaySound(sound[list])
                                    end
                                    set_enable(dialog.settings[10][1].mode,"{d07aff}",list + 1)
                                    st.settings.sound = list
                                    func.SaveJson(st, "moonloader/eazy_news.json")
                                    return true
                                end,dialog.settings[1])
                            end
                        }
                    }
                },
                {  -- 11
                    settings = {title = "Команда для вызова окна" ,style = 1 ,btn1 = "Изменить",btn2 = "Назад",forward =  "{ff0000}" ,backwards = "\n" ,score = false},
                    {
                        text = "{ffffff}Укажите команду для вызова окна\n{ff0000}Команду можно указать без `/`",
                        {
                            click = function(button, list, input, outs)
                                return select_button(button, function()
                                    if tostring(input) ~= "" then
                                        local input = tostring(input):gsub("/","")
                                        if not sampIsChatCommandDefined(input) then
                                            if sampUnregisterChatCommand(st.settings.cmd[outs]) then
                                                sampRegisterChatCommand(input, (outs == 1 and first_menu or second_menu))
                                                sampAddChatMessage("Команда {cecece}/"..input.."{cecece} зарегистрирована, теперь меню доступно по новой команде.", 0xcececece)
                                                st.settings.cmd[outs] = input
                                                func.SaveJson(st, "moonloader/eazy_news.json")
                                                return dialog.settings[1]
                                            else
                                                sampAddChatMessage("Ошибка удаления команды.", 0xcececece)
                                                return true
                                            end
                                        else
                                            sampAddChatMessage("Данная команда уже зарегистрирована другим скриптом.", 0xcececece)
                                            return true
                                        end
                                    else
                                        sampAddChatMessage("Вы ничего не ввели.", 0xcececece)
                                        return true
                                    end
                                end,dialog.settings[1], outs)
                            end
                        }
                    }
                }
            }
}

func = {
    ["LoadJson"] = function(path)
        if doesFileExist(path) then
            local f = io.open(path)
            local cfg = decodeJson(f:read('*a'))
            f:close()
            return cfg
        else
            local f = io.open(path, 'w')
            f:write(encodeJson(st))
            f:close()
            return st
        end
    end,
    ["SaveJson"] = function(table,path)
        local f = io.open(path, 'w')
        f:write(encodeJson(table))
        f:close()
    end,
    ["len"] = function(text)
        return #tostring(text):gsub('[\128-\191]', '')
    end,
    ["turn_enable"] = function()
        return (#st.news < 1 and dialog.turn.no or dialog.turn.yes)
    end,
    ["auto_enable"] = function(tbl)
        local tb = {
            [0] = {false,false},
            [1] = {true,false},
            [2] = {false,true},
            [3] = {true,true}
        }
        return tb[st.settings.auto][(#tbl > 1 and 2 or 1)] 
    end,
    ["get_param"] = function()
        local _, my_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        return {my_id,sampGetPlayerNickname(my_id)}
    end,
    ["GetTimeFormat"] = function(time)
        local timezone_offset = 86400 - os.date('%H', 0) * 3600
        local time = time + timezone_offset--%d
        return  os.date((os.date("%H",time) == "00" and '%M:%S' or '%H:%M:%S'), time)
    end,
    ["StartDialog"] = function(menu,id,outs)
        function _dialog(menu, id, outs)
            local text = tbl_split(menu.settings.style, menu, menu.settings.forward ,menu.settings.backwards ,menu.settings.score)
            sampShowDialog(id, (type(menu.settings.title) == "function" and menu.settings.title() or menu.settings.title), text, (type(menu.settings.btn1) == "function" and  menu.settings.btn1() or menu.settings.btn1), (type(menu.settings.btn2) == "function" and menu.settings.btn2() or (menu.settings.btn2 ~= nil and menu.settings.btn2 or _)), menu.settings.style)
            r_dialog = {id,menu,outs}    
        end
        function tbl_split(style, tbl, forward ,backwards ,score)
            if style == 2 or style == 4 or style == 5 then
                if tbl[1].mode ~= nil then
                    text = (style == 5 and tbl[1].text.."\n" or "")..table.concat((type(tbl[1].mode) == "function" and tbl[1].mode() or tbl[1].mode) ,"\n")..backwards
                else
                    text = (style == 5 and tbl[1].text.."\n" or "")
                    for i, val in ipairs(tbl[1]) do
                        text = text..""..forward..""..(score and "{ff0000}"..i..") " or "").."{ffffff}"..(type(val.title) == "string" and val.title or table.concat(val.title," "))..""..(val.titles ~= nil and val.titles() or "")..""..backwards
                    end
                end
                if tbl[2] ~= nil then
                    for _, val in ipairs(tbl[2]) do
                        text = text..""..forward..""..(type(val.title) == "string" and val.title or table.concat(val.title," "))..""..(val.titles ~= nil and val.titles() or "")..""..backwards
                    end
                end
                return text
            end
            return (type(tbl[1].text) == "function" and tbl[1].text() or tbl[1].text)
        end
        function select_button(count,btn1,btn2, out)
            if count == 1 then
                if type(btn1) == "function" then
                    return btn1(), out
                else
                    return btn1, out
                end
            else
                if type(btn2) == "function" then
                    return btn2(), out
                else
                    return btn2, out
                end
            end
        end
        function set_enable(tbl,text,select)
            for i, val in ipairs(tbl) do
                tbl[i] = string.gsub(val,"{.+}","")
            end
            tbl[select] = text..""..tbl[select]
        end
        return _dialog(menu, id or 1337, outs)
    end
}

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    sampAddChatMessage("{ffcece}Easy News v. 2.0.1{cecece} загружен! Автор: {ffcece}trefa{cecece}.", 0xffcece)
    st = func.LoadJson("moonloader/eazy_news.json")
    font = CreateDirectFont()
    MoonAdd()
    update_table()
    sampRegisterChatCommand(st.settings.cmd[1], first_menu)
    sampRegisterChatCommand(st.settings.cmd[2], second_menu)
    while true do
        wait(0)
        renders()
        if lock and  os.clock() - gnews_timer > 20.0 then
            lock,last_gnews = false,""
            sampAddChatMessage("Время ожидания кончилось.", 0xffcecece)
        end
        if st.news[1] ~= nil then
            tm = st.news[1][1] - os.time()
            if tm < 30 and st.settings.sound ~= 0 then
                if tm ~= mm then
                    EmulRPCPlayerPlaySound(sound[st.settings.sound])
                    mm = tm
                end
            end
            if tm < 0 then
                if not sampIsDialogActive() then
                    if not ob then
                        nm,buff_gnews = true,st.news[1]
                        if st.settings.sound ~= 0 then EmulRPCPlayerPlaySound(3201) end
                        func.StartDialog(dialog.gnews.to_lodge)
                    else
                        sampAddChatMessage("Сейчас идёт подача новости.", 0xffcecece)
                    end
                else
                    sampAddChatMessage("Было открыто другое диалоговое окно.", 0xffcecece)
                end
                update_table()
            end
        else
            tm = -1
        end
    end
end

function CreateDirectFont()
    local font = {}
    for i, val in ipairs(ren) do
        if not st.settings[val].sp and st.settings[val].render then
            font[i] = renderCreateFont(st.settings[val].direct.font, st.settings[val].direct.size, #style_d[st.settings[val].direct.style] ~= 2 and flag[style_d[st.settings[val].direct.style]] or flag[style_d[st.settings[val].direct.style][1]] + flag[style_d[st.settings[val].direct.style][2]])
        else
            font[i] = nil
        end
    end
    return font
end

function first_menu()
    func.StartDialog(dialog.main)
end

function second_menu()
    nt = true
    func.StartDialog(func.turn_enable())
end

function to_lodge(tbl)
    ob = true
    for i, val in ipairs(tbl[2]) do
        sampSendChat("/gnews "..val)
        if #tbl[2] > 1 and i ~= tbl[2] then wait(time[tbl[3]]) end
    end
    if func.auto_enable(tbl[2]) then wait(1000) sampSendChat("/time") wait(1000) memory.setuint8(sampGetBase() + 0x119CBC, 1) end
    ob = false
end

function EmulRPCPlayerPlaySound(id)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt32(bs, id)
    raknetBitStreamWriteFloat(bs, 0)
    raknetBitStreamWriteFloat(bs, 0)
    raknetBitStreamWriteFloat(bs, 0)
    raknetEmulRpcReceiveBitStream(16, bs)
    raknetDeleteBitStream(bs)
end

function update_table()
local ry = math.huge
local yy = 0
table.sort(st.news, function(a,b) if b ~= nil then if a[1] > b[1] then return false else return true end else return true end end)
    for i = 1,#st.news do
        if st.news[i] ~= nil then
            if st.news[i][1] < os.time() then
                sampAddChatMessage("Новость ''{4465cc}"..tostring(st.news[i][2][1]).."{cecece}'' была удалена из очереди.", 0xcececece)
                table.remove(st.news,i)
                func.SaveJson(st, "moonloader/eazy_news.json")
            end
        end
    end
end

function MoonAdd()
    if not status then
        sampAddChatMessage("Библиотека MoonAdditions не установлена! Некоторые функции могут быть недоступны.",0xcecece)
        if st.settings.timer.sp then
            st.settings.timer.sp = false
        end
        if st.settings.time.sp then
            st.settings.time.sp = false
        end
        if st.settings.gos.sp then
            st.settings.gos.sp = false
        end
    end
end


function direct(text,font,align,x,y)
    if font ~= nil then
        local len = renderGetFontDrawTextLength(font, text, false)
        renderFontDrawText(font, text, (align == 2 and x or (align == 1 and x - len / 2 or x - len)), y, -1)
    end
end

function madr(text,style,size,align,ob,x,y)
    mad.draw_text(text, x, y, mad.font_style[style], size, size * 2, mad.font_align[align], 2000, true, false, 255, 255, 255, 255, ob, 0, 30, 30, 30, 120)
end

function RusToGame(text)
    local convtbl = {[230]=155,[231]=159,[247]=164,[234]=107,[250]=144,[251]=168,[254]=171,[253]=170,[255]=172,[224]=97,[240]=112,[241]=99,[226]=162,[228]=154,[225]=151,[227]=153,[248]=165,[243]=121,[184]=101,[235]=158,[238]=111,[245]=120,[233]=157,[242]=166,[239]=163,[244]=63,[237]=174,[229]=101,[246]=36,[236]=175,[232]=156,[249]=161,[252]=169,[215]=141,[202]=75,[204]=77,[220]=146,[221]=147,[222]=148,[192]=65,[193]=128,[209]=67,[194]=139,[195]=130,[197]=69,[206]=79,[213]=88,[168]=69,[223]=149,[207]=140,[203]=135,[201]=133,[199]=136,[196]=131,[208]=80,[200]=133,[198]=132,[210]=143,[211]=89,[216]=142,[212]=129,[214]=137,[205]=72,[217]=138,[218]=167,[219]=145}
    local result = {}
    for i = 1, #text do
        local c = text:byte(i)
        result[i] = string.char(convtbl[c] or c)
    end
    return table.concat(result)
end




function onWindowMessage(msg, wparam, lparam)
    if #r_dialog > 1 then
    local result, button, list, input = sampHasDialogRespond(r_dialog[1])
        if result then
            if r_dialog[2][1].mode ~= nil then
                local mode = (type(r_dialog[2][1].mode) == "function" and r_dialog[2][1].mode() or r_dialog[2][1].mode)
                out, outs = (#mode < (list + 1) and r_dialog[2][2][(list + 1) - #mode] or r_dialog[2][1][1]).click(button, list, input, outs)
            else
                out, outs = r_dialog[2][((r_dialog[2].settings.style == 0 or r_dialog[2].settings.style == 1 or r_dialog[2].settings.style == 3) and 1 or ((list + 1) > #r_dialog[2][1] and 2 or 1))][((r_dialog[2].settings.style == 0 or r_dialog[2].settings.style == 1 or r_dialog[2].settings.style == 3) and 1 or ((list + 1) > #r_dialog[2][1] and (list - #r_dialog[2][1]) + 1  or list + 1))].click(button, list, input, outs)
            end
            local typ = {["table"] = function(menu, id, outs, out) return out, id - 1, outs end,["boolean"] = function(menu, id, outs, out) if out then return menu, id, outs else return out end end}
            local ret = typ[type(out)](r_dialog[2], r_dialog[1], outs, out)
            r_dialog = {}
            if ret then
                func.StartDialog(ret)
            end
        end
    end

    if msg == 0x0200 and pos > 0 then
        st.settings[ren[pos]].x,st.settings[ren[pos]].y = getCursorPos()
    end
    if msg == 0x0203 and wparam == 0x0001 and pos > 0 then
        consumeWindowMessage(true, true)
        showCursor(false, false)
        sampAddChatMessage("Положение сохранено.", -1)
        mode = pos - 1
        pos = 0
        func.SaveJson(st, "moonloader/eazy_news.json")
        func.StartDialog(dialog.settings[3])
    end
end

function renders()
    if st.settings.timer.render or pos == 1 then
        if st.settings.timer.sp then
            madr((#st.news < 1 and text_r[(st.settings.timer.lang and 1 or 2)][2][1] or text_r[(st.settings.timer.lang and 1 or 2)][2][2]..(tm < 60 and "~r~" or "~p~").."_"..((st.news[1][1] - os.time() > 86400) and text_r[(st.settings.timer.lang and 1 or 2)][2][3] or func.GetTimeFormat(tm)).. "~w~."),style_m[st.settings.timer.mad.style + 1], st.settings.timer.mad.size,align[st.settings.timer.mad.align][2],st.settings.timer.mad.ob,st.settings.timer.x, st.settings.timer.y)
        elseif not st.settings.timer.sp and font[1] ~= nil then
            direct((#st.news < 1 and text_r[(st.settings.timer.lang and 1 or 2)][1][1] or text_r[(st.settings.timer.lang and 1 or 2)][1][2]..(tm < 60 and "{f90421}" or "{e151f7}").." "..((st.news[1][1] - os.time() > 86400) and text_r[(st.settings.timer.lang and 1 or 2)][1][3] or func.GetTimeFormat(tm)).. "{ffffff}."),font[1],st.settings.timer.direct.align,st.settings.timer.x,st.settings.timer.y)
        end
    end
    if st.settings.time.render or pos == 2 then -- text_r[(st.settings.timer.lang and 1 or 2)][1][3]
        if st.settings.time.sp then
            madr(os.date("%X").."~n~"..os.date("%d").."_"..mes_rus[(st.settings.time.lang and 1 or 2)][2][tonumber(os.date("%m"))].."_"..os.date("%Y")..text_r[(st.settings.time.lang and 1 or 2)][2][4],style_m[st.settings.time.mad.style + 1], st.settings.time.mad.size,align[st.settings.time.mad.align][2],st.settings.time.mad.ob,st.settings.time.x, st.settings.time.y)
        elseif not st.settings.time.sp and font[2] ~= nil then
            direct(os.date("%X"),font[2],st.settings.time.direct.align,st.settings.time.x,st.settings.time.y)
            direct(os.date("%d").." "..mes_rus[(st.settings.time.lang and 1 or 2)][1][tonumber(os.date("%m"))].." "..os.date("%Y")..text_r[(st.settings.time.lang and 1 or 2)][1][4],font[2],st.settings.time.direct.align,st.settings.time.x,st.settings.time.y + renderGetFontDrawHeight(font[2]))
        end
    end
    if st.settings.gos.render or pos == 3 then
        local dtime = os.date("*t")
        dtime.hour,dtime.min,dtime.sec = 0, 0, 0
        if st.settings.gos.sp then
            if #st.news < 1 then
                madr(text_r[(st.settings.gos.lang and 1 or 2)][2][5],style_m[st.settings.gos.mad.style + 1], st.settings.gos.mad.size,align[st.settings.gos.mad.align][2],st.settings.gos.mad.ob,st.settings.gos.x, st.settings.gos.y)
            else
                for i, val in ipairs(st.news) do
                    if #st.news > 0 and i ~= nil and val ~= nil then
                        local ntime = (math.floor((val[1] - os.time(dtime)) / 86400) + 1)
                        madr("~r~"..i.."~w~__"..RusToGame(val[2][1]):gsub("%s","_").."__~p~"..(dayr[(st.settings.gos.lang and 1 or 2)][2][ntime] ~= nil and dayr[(st.settings.gos.lang and 1 or 2)][2][ntime]..text_r[(st.settings.gos.lang and 1 or 2)][2][7] or text_r[(st.settings.gos.lang and 1 or 2)][2][6].."_")..os.date("%H:%M:%S",val[1]),style_m[st.settings.gos.mad.style + 1], st.settings.gos.mad.size,align[st.settings.gos.mad.align][2],st.settings.gos.mad.ob,st.settings.gos.x, st.settings.gos.y + ((st.settings.gos.mad.size * 35) * (i - 1)))
                    end
                end
            end
        elseif not st.settings.gos.sp and font[3] ~= nil then
            if #st.news < 1 then
                direct(text_r[(st.settings.gos.lang and 1 or 2)][1][5],font[3],st.settings.gos.direct.align,st.settings.gos.x,st.settings.gos.y)
            else
                local si = renderGetFontDrawHeight(font[3])
                for i, val in ipairs(st.news) do 
                    if #st.news > 0 and i ~= nil and val ~= nil then
                        local ntime = (math.floor((val[1] - os.time(dtime)) / 86400) + 1)
                        direct("{ff0000}"..i.."{ffffff}  "..val[2][1].."  {e151f7} "..(dayr[(st.settings.gos.lang and 1 or 2)][1][ntime] ~= nil and dayr[(st.settings.gos.lang and 1 or 2)][1][ntime]..text_r[(st.settings.gos.lang and 1 or 2)][1][7] or text_r[(st.settings.gos.lang and 1 or 2)][1][6].." ")..os.date("%H:%M:%S",val[1]),font[3],st.settings.gos.direct.align,st.settings.gos.x,st.settings.gos.y + ((i - 1) * si))
                    end
                end
            end
        end
    end
end

function onSendRpc(id, bs)
    if RPC[id] ~= nil then
        return RPC[id](bs)
    end
end

RPC = {
    [50] = function(bs)
        local com = raknetBitStreamReadString(bs, raknetBitStreamReadInt32(bs))
        if st.settings.news and com:find("^/gnews%s+(.+)$") and not ob then
            local param1 = com:match("^/gnews%s+(.+)$")
            if last_gnews == "" and not lock then
                last_gnews,lock,gnews_timer = param1,true,os.clock()
                sampAddChatMessage("Вы собираетесь подать новость ''"..tostring(param1).."''.", 0xffcecece)
                sampAddChatMessage("Для подачи повторите её в течении 20 секунд.", 0xffcecece)
                return false
            else
                if last_gnews ~= param1 then
                    sampAddChatMessage("Гос. новости не сходятся.", 0xffcecece)
                    last_gnews,lock,gnews_timer = "",false,0
                    return false
                else
                    last_gnews,lock,gnews_timer = "",false,0
                end
            end
        end
    end
}