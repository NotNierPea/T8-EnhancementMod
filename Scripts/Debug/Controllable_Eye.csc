Eye_Change_Camera()
{
	while(true)
	{
		ChangeCamera(getDvarFloat(#"shield_enh_eye_camera_height", 0), getDvarFloat(#"shield_enh_eye_camera_range", 0));
		wait 0.25;
	}
}

ChangeCamera(Height, Range)
{
	function_ac297091(0, Height);
	function_d69242bb(0, Range);
}