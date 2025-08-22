#include "SDLGamepad.h"


namespace lime {


	std::map<int, SDLGamepad> gameControllers;
	std::map<int, int> gameControllerIDs;

	void SDLGamepad::Rumble (double lowFrequencyRumble, double highFrequencyRumble, int duration) {
		// Make sure game controller is open
		if (gameController == nullptr)
			return;

		// Rumble controller
		if (highFrequencyRumble < 0.0f)
			highFrequencyRumble = 0.0f;
		else if (highFrequencyRumble > 1.0f)
			highFrequencyRumble = 1.0f;

		if (lowFrequencyRumble < 0.0f)
			lowFrequencyRumble = 0.0f;
		else if (lowFrequencyRumble > 1.0f)
			lowFrequencyRumble = 1.0f;

		if (duration < 0)
			duration = 0;
		else if (duration > 0xFFFF)
			duration = 0xFFFF;

		SDL_GameControllerRumble (gameController, lowFrequencyRumble * 0xFFFF, highFrequencyRumble * 0xFFFF, duration);
	}


	// SDL static gamepad API
	bool SDLGamepad::Connect (int deviceID) {

		if (SDL_IsGameController (deviceID)) {

			SDL_GameController *gameController = SDL_GameControllerOpen (deviceID);

			if (gameController != nullptr) {

				SDL_Joystick *joystick = SDL_GameControllerGetJoystick (gameController);
				int id = SDL_JoystickInstanceID (joystick);

				gameControllers[id] = std::move (SDLGamepad (gameController));
				gameControllerIDs[deviceID] = id;

				return true;

			}

		}

		return false;

	}


	bool SDLGamepad::Disconnect (int id) {

		if (gameControllers.find (id) != gameControllers.end ()) {

			gameControllers.erase (id);
			return true;

		}

		return false;

	}


	int SDLGamepad::GetInstanceID (int deviceID) {

		return gameControllerIDs[deviceID];

	}


	// Gamepad API
	void Gamepad::AddMapping (const char* content) {

		SDL_GameControllerAddMapping (content);

	}


	const char* Gamepad::GetDeviceGUID (int id) {
		auto it = gameControllers.find (id);
		if (it == gameControllers.end ())
			return nullptr;

		SDL_Joystick* joystick = SDL_GameControllerGetJoystick (it->second.gameController);

		if (joystick) {

			char* guid = new char[64];
			SDL_JoystickGetGUIDString (SDL_JoystickGetGUID (joystick), guid, 64);
			return guid;

		}

		return nullptr;

	}


	const char* Gamepad::GetDeviceName (int id) {
		auto it = gameControllers.find (id);
		if (it == gameControllers.end ())
			return nullptr;

		return SDL_GameControllerName (it->second.gameController);
	}

	void Gamepad::Rumble (int id, double lowFrequencyRumble, double highFrequencyRumble, int duration) {
		auto it = gameControllers.find (id);
		if (it == gameControllers.end ())
			return;

		it->second.Rumble (lowFrequencyRumble, highFrequencyRumble, duration);
	}
}
