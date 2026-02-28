package lime._internal.macros;

#if macro
import haxe.macro.Expr.Position;
import haxe.macro.Expr.Access;
import haxe.macro.ExprTools;
import haxe.macro.Expr.FieldType;
import haxe.macro.Type.FieldAccess;
import haxe.macro.Type.FieldKind;
import haxe.macro.Context;
import haxe.macro.Expr.Field;

class TimerMacro
{
	private static final tab:String = '    ';
	public static final fieldsToRemove:Array<String> = ['id', 'thread', 'eventHandler', 'event'];

	public static function build():Array<Field>
	{
		var fields:Array<Field> = Context.getBuildFields();

		if (!Context.defined('lime-cffi'))
			return fields;

		final pos = Context.currentPos();

		fields = fields.filter(f -> !fieldsToRemove.contains(f.name));
		fields = addExtraFields(fields, pos);

		for (field in fields)
		{
			// Sanity cheks for Timer.stamp method
			switch (field.name)
			{
				case 'stamp':
					switch (field.kind)
					{
						case FFun(func):
							func.expr = Context.parse(getStampBody(), pos);
						default:
					}
				case 'new':
					switch (field.kind)
					{
						case FFun(func):
							func.args[0].type = macro :Float;
							func.expr = Context.parse(getConstructorBody(), pos);
						default:
					}
				case 'stop':
					switch (field.kind)
					{
						case FFun(func):
							func.expr = Context.parse(getStopBody(), pos);
						default:
					}
				case 'delay':
					switch (field.kind)
					{
						case FFun(func):
							func.args[1].type = macro :Float;
						default:
					}
			}
		}

		return fields;
	}

	private static function getStampBody():String
	{
		// var timer = System.getTimer();
		// return (timer > 0 ? timer / 1000 : 0);

		var functionBody:String = '{\n';
		functionBody += '${tab}var timer = lime.system.System.getTimer();\n';
		functionBody += '${tab}return (timer > 0 ? timer / 1000 : 0);\n';
		functionBody += '}';

		return functionBody;
	}

	private static function getConstructorBody():String
	{
		// mTime = time_ms;
		// sRunningTimers.push(this);
		// mFireAt = getMS() + mTime;
		// mRunning = true;

		var functionBody:String = '{\n';
		functionBody += '${tab}mTime = time_ms;\n';
		functionBody += '${tab}sRunningTimers.push(this);\n';
		functionBody += '${tab}mFireAt = getMS() + mTime;\n';
		functionBody += '${tab}mRunning = true;\n';
		functionBody += '}';

		return functionBody;
	}

	private static function getStopBody():String
	{
		// mRunning = false;

		var functionBody:String = '{\n';
		functionBody += '${tab}mRunning = false;\n';
		functionBody += '}';

		return functionBody;
	}

	private static function getGetMSBody():String
	{
		// return lime.system.System.getTimer();

		var functionBody:String = '{\n';
		functionBody += '${tab}return lime.system.System.getTimer();\n';
		functionBody += '}';

		return functionBody;
	}

	private static function getCheckBody():String
	{
		// if (inTime >= mFireAt)
		// {
		// mFireAt += mTime;
		// run();
		// }

		var functionBody:String = '{\n';
		functionBody += '${tab}if (inTime >= mFireAt)\n';
		functionBody += '${tab}{\n';
		functionBody += '${tab + tab}mFireAt += mTime;\n';
		functionBody += '${tab + tab}run();\n';
		functionBody += '${tab}}\n';
		functionBody += '}';

		return functionBody;
	}

	private static function addExtraFields(fields:Array<Field>, pos:Position):Array<Field>
	{
		function hasField(name:String):Bool
		{
			for (f in fields)
				if (f.name == name)
					return true;

			return false;
		}

		if (!hasField('sRunningTimers'))
		{
			fields.push({
				name: 'sRunningTimers',
				access: [Access.APrivate, Access.AStatic],
				kind: FVar(macro :Array<haxe.Timer>, macro $v{[]}),
				pos: pos
			});
		}
		if (!hasField('mTime'))
		{
			fields.push({
				name: 'mTime',
				access: [Access.APrivate],
				kind: FVar(macro :Float, macro $v{0}),
				pos: pos
			});
		}
		if (!hasField('mFireAt'))
		{
			fields.push({
				name: 'mFireAt',
				access: [Access.APrivate],
				kind: FVar(macro :Float, macro $v{0}),
				pos: pos
			});
		}
		if (!hasField('mRunning'))
		{
			fields.push({
				name: 'mRunning',
				access: [Access.APrivate],
				kind: FVar(macro :Bool, macro $v{false}),
				pos: pos
			});
		}
		if (!hasField('getMS'))
		{
			fields.push({
				name: 'getMS',
				access: [Access.APrivate, Access.AStatic],
				kind: FFun({
					args: [],
					params: [],
					ret: macro :Float,
					expr: Context.parse(getGetMSBody(), pos)
				}),
				pos: pos
			});
		}
		if (!hasField('__check'))
		{
			fields.push({
				name: '__check',
				access: [Access.APrivate],
				kind: FFun({
					args: [{name: "inTime", type: macro :Float, opt: false}],
					params: [],
					expr: Context.parse(getCheckBody(), pos)
				}),
				meta: [{name: 'noCompletion', pos: pos}],
				pos: pos
			});
		}

		return fields;
	}
}
#end
