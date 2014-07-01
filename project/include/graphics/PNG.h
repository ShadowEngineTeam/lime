#ifndef LIME_GRAPHICS_PNG_H
#define LIME_GRAPHICS_PNG_H


namespace lime {
	
	class ImageData;
	
	class PNG {
		
		
		public:
			
			static bool Decode (const char *path, ImageData *imageData);
		
		
	};
	
	
}


#endif