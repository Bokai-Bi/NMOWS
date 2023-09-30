using Godot;
using System;

public partial class Player : RigidBody2D
{
	[Export]
	public float MOVE_SPEED {get; set;}= 20.0f;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(double delta)
	{
		var move_vec = Vector2.Zero;
		if(Input.IsActionPressed("move_up")){
			move_vec.Y -= 1.0f;
		}
		if(Input.IsActionPressed("move_down")){
			move_vec.Y += 1.0f;
		}
		if(Input.IsActionPressed("move_left")){
			move_vec.X -= 1.0f;
		}
		if(Input.IsActionPressed("move_right")){
			move_vec.X += 1.0f;
		}
		move_vec = move_vec.Normalized() * MOVE_SPEED * (float)delta;
		MoveAndCollide(move_vec);
	}
}
