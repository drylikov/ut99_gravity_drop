//==================================================================================
// TriggerGravityZone: A ZoneInfo where gravity can be triggered between two states.
//==================================================================================
// Author: Jamie York <ziadoz@gmail.com> 
// Usage:
// Use a trigger to flip the gravity. 
// Use a dispatcher to flip it, delay, and then flip it back.

class TriggerGravityZone expands ZoneInfo;

var() Vector InitialGravity;
var() Vector TriggeredGravity;
var() localized string InitialGravityMessage;
var() localized string TriggeredGravityMessage;
var bool bTriggered;

function BeginPlay()
{
	ZoneGravity = InitialGravity; // Set the initial gravity.
	Super.BeginPlay();
	bTriggered = False;
}

function Trigger( actor Other, pawn EventInstigator )
{
	if ( bTriggered == False )
	{
		ZoneGravity = TriggeredGravity;
		
		bTriggered = True;
		
		Other.Instigator.ClientMessage(TriggeredGravityMessage);
	}
	else
	{
		ZoneGravity = InitialGravity;
		
		bTriggered = False;
		
		BroadcastMessage("Gravity Reset");
		
		Other.Instigator.ClientMessage(InitialGravityMessage);
	}
}

defaultproperties
{
	InitialGravity=(Z=-950.000000) // The initial gravity of the ZoneInfo (Default: Earth)
	TriggeredGravity=(Z=-200.000000) // The triggered gravity of the ZoneInfo (Default: Space)
	InitialGravityMessage="" // A message to display when the initial gravity is active.
	TriggeredGravityMessage="" // A message to display when the triggered gravity is active.
}
