-- 设置不可以移动的app名称
local ignored_apps = {
    'QQ',
    '微信',
}

function ignored(win)
    local app = win:application()
    if app then
	local title = app:title()
	print('identifier'..title)
	return hs.fnutils.contains(ignored_apps, title)
    end
    return false
end

return ignored
