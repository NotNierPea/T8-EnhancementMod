# usage: blender -b --factory-startup --python make_wiggle.py -- <out.gltf>
# enh_wiggle: a 60 units column of 4 bones (tag_origin, j_seg1..3), skinned by height, a 1 second looping wiggle
# (enh_wiggle_loop) and a 2 seconds walk of tag_origin (enh_wiggle_walk, root motion), in game units, z up
import bpy, sys, math
from mathutils import Vector

out = sys.argv[sys.argv.index("--") + 1]
bpy.ops.wm.read_factory_settings(use_empty=True)
scene = bpy.context.scene
scene.render.fps = 30
scene.frame_start, scene.frame_end = 0, 30

# the column: 16 sides, a ring every 5 units
HEIGHT, RADIUS, SIDES, RINGS = 60.0, 4.0, 16, 12
verts, faces = [], []
for r in range(RINGS + 1):
    z = HEIGHT * r / RINGS
    for s in range(SIDES):
        a = 2 * math.pi * s / SIDES
        verts.append((RADIUS * math.cos(a), RADIUS * math.sin(a), z))
for r in range(RINGS):
    for s in range(SIDES):
        a, b = r * SIDES + s, r * SIDES + (s + 1) % SIDES
        faces.append((a, b, b + SIDES, a + SIDES))
verts.append((0, 0, 0)); verts.append((0, 0, HEIGHT))
bot, top = len(verts) - 2, len(verts) - 1
for s in range(SIDES):
    faces.append((bot, (s + 1) % SIDES, s))
    faces.append((top, RINGS * SIDES + s, RINGS * SIDES + (s + 1) % SIDES))
mesh = bpy.data.meshes.new("enh_wiggle")
mesh.from_pydata(verts, [], faces)
mesh.update()
uv = mesh.uv_layers.new(name="UVMap")
for poly in mesh.polygons:
    for li in poly.loop_indices:
        v = mesh.vertices[mesh.loops[li].vertex_index].co
        uv.data[li].uv = (math.atan2(v.y, v.x) / (2 * math.pi) + 0.5, v.z / HEIGHT)
mat = bpy.data.materials.new("wiggle")
mesh.materials.append(mat)
obj = bpy.data.objects.new("enh_wiggle", mesh)
scene.collection.objects.link(obj)

# the bones: tag_origin at the bottom, three segments up the column
arm_data = bpy.data.armatures.new("enh_wiggle_skel")
arm = bpy.data.objects.new("enh_wiggle_skel", arm_data)
scene.collection.objects.link(arm)
bpy.context.view_layer.objects.active = arm
bpy.ops.object.mode_set(mode='EDIT')
bones = {}
for name, h, t, parent in [("tag_origin", 0, 5, None), ("j_seg1", 0, 20, "tag_origin"),
                           ("j_seg2", 20, 40, "j_seg1"), ("j_seg3", 40, 60, "j_seg2")]:
    b = arm_data.edit_bones.new(name)
    b.head, b.tail = Vector((0, 0, h)), Vector((0, 0, t))
    if parent:
        b.parent = bones[parent]
    bones[name] = b
bpy.ops.object.mode_set(mode='OBJECT')

# weights: each ring between the two segments around it
groups = {n: obj.vertex_groups.new(name=n) for n in ("j_seg1", "j_seg2", "j_seg3")}
for i, v in enumerate(mesh.vertices):
    z = v.co.z
    for name, centre in (("j_seg1", 10), ("j_seg2", 30), ("j_seg3", 50)):
        w = max(0.0, 1.0 - abs(z - centre) / 20.0)
        if w > 0:
            groups[name].add([i], w, 'REPLACE')
obj.parent = arm
mod = obj.modifiers.new("skin", 'ARMATURE')
mod.object = arm

# the loop: the segments sway around x and y, frame 30 back on frame 0
arm.animation_data_create()
action = bpy.data.actions.new("enh_wiggle_loop")
arm.animation_data.action = action
bpy.context.view_layer.objects.active = arm
bpy.ops.object.mode_set(mode='POSE')
for f in range(0, 31, 2):
    t = 2 * math.pi * f / 30
    for i, name in enumerate(("j_seg1", "j_seg2", "j_seg3")):
        pb = arm.pose.bones[name]
        pb.rotation_mode = 'XYZ'
        pb.rotation_euler = (math.radians(18) * math.sin(t + i * 0.8), 0, math.radians(10) * math.cos(t + i * 0.8))
        pb.keyframe_insert("rotation_euler", frame=f)
bpy.ops.object.mode_set(mode='OBJECT')

# the walk: tag_origin goes 100 units forward and turns 90 degrees in 2 seconds, the segments sway (root motion)
walk = bpy.data.actions.new("enh_wiggle_walk")
arm.animation_data.action = walk
bpy.ops.object.mode_set(mode='POSE')
for f in range(0, 61, 2):
    t = f / 60
    root = arm.pose.bones["tag_origin"]
    root.rotation_mode = 'XYZ'
    # bone space: the bone points up (y = world z), its x is world x, its z world -y
    root.location = (100 * t, 0, 0)
    root.rotation_euler = (0, math.radians(90) * t, 0)
    root.keyframe_insert("location", frame=f)
    root.keyframe_insert("rotation_euler", frame=f)
    for i, name in enumerate(("j_seg1", "j_seg2", "j_seg3")):
        pb = arm.pose.bones[name]
        pb.rotation_mode = 'XYZ'
        pb.rotation_euler = (math.radians(12) * math.sin(4 * math.pi * t + i), 0, 0)
        pb.keyframe_insert("rotation_euler", frame=f)
bpy.ops.object.mode_set(mode='OBJECT')

# both actions on nla tracks so the exporter writes both
for act in (action, walk):
    track = arm.animation_data.nla_tracks.new()
    track.name = act.name
    track.strips.new(act.name, 0, act)
arm.animation_data.action = None

bpy.ops.export_scene.gltf(filepath=out, export_format='GLTF_SEPARATE', export_animations=True, export_skins=True,
                          export_yup=True, export_apply=False, export_animation_mode='ACTIONS')
print("written", out)
