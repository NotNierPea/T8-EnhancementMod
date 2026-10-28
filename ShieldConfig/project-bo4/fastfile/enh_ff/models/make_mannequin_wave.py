# usage: blender -b --factory-startup --python make_mannequin_wave.py -- <skeleton.gltf> <out.gltf> [bones.json]
# enh_mannequin_wave: on the zm_body skeleton (acts' glTF of skeletons/zm_body.json), a 1 second loop at 30 fps: the
# left arm waves, the head nods, the spine twists. bones.json gets where blender puts some bones (game units, z up,
# blender's world is the game's) to check the xanim against.
import bpy, sys, math, json

a = sys.argv[sys.argv.index("--") + 1:]
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.gltf(filepath=a[0])
for o in list(bpy.context.scene.objects):
    if o.type == 'MESH' and not o.find_armature():
        bpy.data.objects.remove(o)
arm = next(o for o in bpy.context.scene.objects if o.type == 'ARMATURE')
scene = bpy.context.scene
scene.render.fps = 30
scene.frame_start, scene.frame_end = 0, 30
arm.animation_data_clear()
arm.animation_data_create()
action = bpy.data.actions.new("enh_mannequin_wave")
arm.animation_data.action = action
bpy.context.view_layer.objects.active = arm
bpy.ops.object.mode_set(mode='POSE')
moves = {
    # bone: (axis, degrees, phase); the axes are blender's bone axes
    "j_shoulder_le": (0, 70, 0.0),
    "j_elbow_le": (2, 40, 0.5),
    "j_neck": (0, 15, 0.25),
    "j_spinelower": (1, 12, 0.0),
}
for f in range(0, 31, 2):
    t = 2 * math.pi * f / 30
    for name, (axis, deg, phase) in moves.items():
        pb = arm.pose.bones[name]
        pb.rotation_mode = 'XYZ'
        r = [0.0, 0.0, 0.0]
        r[axis] = math.radians(deg) * math.sin(t + phase * 2 * math.pi)
        pb.rotation_euler = r
        pb.keyframe_insert("rotation_euler", frame=f)
bpy.ops.object.mode_set(mode='OBJECT')

if len(a) > 2:
    out = {}
    for f in (0, 5, 10, 15, 20, 25):
        scene.frame_set(f)
        bpy.context.view_layer.update()
        out[f] = {n: list(arm.matrix_world @ arm.pose.bones[n].head) for n in ("j_wrist_le", "j_elbow_le", "j_head", "j_spine4", "j_wrist_ri", "j_ankle_le")}
    json.dump(out, open(a[2], "w"), indent=1)

track = arm.animation_data.nla_tracks.new()
track.name = action.name
track.strips.new(action.name, 0, action)
arm.animation_data.action = None
bpy.ops.export_scene.gltf(filepath=a[1], export_format='GLTF_SEPARATE', export_animations=True, export_skins=True,
                          export_yup=True, export_apply=False, export_animation_mode='ACTIONS')
print("written", a[1])
