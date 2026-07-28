#include <hx/CFFIPrime.h>
#include <system/ValuePointer.h>


namespace lime {


	ValuePointer::ValuePointer (value handle) {

		cffiRoot = 0;
		cffiValue = alloc_root ();

		if (cffiValue) {

			*cffiValue = handle;

		} else {

			cffiRoot = create_root (handle);

		}

	}


	ValuePointer::~ValuePointer () {

		if (cffiValue) {

			free_root (cffiValue);

		} else if (cffiRoot) {

			destroy_root (cffiRoot);

		}

	}


	void* ValuePointer::Call () {

		return val_call0 ((value)Get ());

	}


	void* ValuePointer::Call (void* arg0) {

		return val_call1 ((value)Get (), (value)arg0);

	}


	void* ValuePointer::Call (void* arg0, void* arg1) {

		return val_call2 ((value)Get (), (value)arg0, (value)arg1);

	}


	void* ValuePointer::Call (void* arg0, void* arg1, void* arg2) {

		return val_call3 ((value)Get (), (value)arg0, (value)arg1, (value)arg2);

	}


	void* ValuePointer::Call (void* arg0, void* arg1, void* arg2, void* arg3) {

		value vals[] = {
			(value)arg0,
			(value)arg1,
			(value)arg2,
			(value)arg3,
		};

		return val_callN ((value)Get (), vals, 4);

	}


	void* ValuePointer::Call (void* arg0, void* arg1, void* arg2, void* arg3, void* arg4) {

		value vals[] = {
			(value)arg0,
			(value)arg1,
			(value)arg2,
			(value)arg3,
			(value)arg4,
		};

		return val_callN ((value)Get (), vals, 5);

	}


	void* ValuePointer::Call (void* arg0, void* arg1, void* arg2, void* arg3, void* arg4, void* arg5) {

		if (!hlValue) {

			value vals[] = {
				(value)arg0,
				(value)arg1,
				(value)arg2,
				(value)arg3,
				(value)arg4,
				(value)arg5
			};

			return val_callN ((value)Get (), vals,6);

		} else {

			vdynamic* args[] = {
				(vdynamic*)arg0,
				(vdynamic*)arg1,
				(vdynamic*)arg2,
				(vdynamic*)arg3,
				(vdynamic*)arg4,
				(vdynamic*)arg5,
			};

			return hl_dyn_call ((vclosure*)hlValue, (vdynamic**)&args, 6);

		}

	}


	void* ValuePointer::Get () const {

		if (cffiValue) {

			return *cffiValue;

		} else if (cffiRoot) {

			return query_root (cffiRoot);

		}

		return 0;

	}


	void ValuePointer::Set (value handle) {

		if (cffiValue) {

			*cffiValue = handle;

		} else {

			if (cffiRoot) destroy_root (cffiRoot);
			cffiRoot = create_root (handle);

		}

	}


}