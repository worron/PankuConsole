class_name PankuModuleExpressionMonitor extends PankuModule
func get_module_name(): return "ExpressionMonitor"

func init_module():
	# register env
	var env = preload("./env.gd").new()
	env._module = self
	core.register_env("expr_monitor", env)


func add_monitor_window(expr:String, update_interval:= 999999.0) -> PankuLynxWindow:
	var content = preload("./monitor/monitor_2.tscn").instantiate()
	content.console = core
	content._update_exp = expr
	content._update_period = update_interval
	var new_window:PankuLynxWindow = core.create_window(content)
	new_window._title_btn.text = expr
	new_window._options_btn.pressed.connect(
		func():
			var window:PankuLynxWindow = core.create_data_controller_window.call(content)
			if window: window.set_caption("Monitor Settings")
	)
	content.change_window_title_text.connect(
		func(text:String):
			new_window._title_btn.text = text
	)
	new_window.title_btn_clicked.connect(content.update_exp_i)
	return new_window