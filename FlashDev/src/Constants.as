package
{
    import starling.errors.AbstractClassError;

    public class Constants
    {
        public function Constants() { throw new AbstractClassError(); }
        
        // We chose this stage size because it is used by many mobile devices; 
        // it's e.g. the resolution of the iPhone (non-retina), which means that your game
        // will be displayed without any black bars on all iPhone models up to 4S.
        // 
        // To use landscape mode, exchange the values of width and height, and 
        // set the "aspectRatio" element in the config XML to "landscape". (You'll also have to
        // update the background, startup- and "Default" graphics accordingly.)
        
        public static const STAGE_WIDTH:int  = 320;
        public static const STAGE_HEIGHT:int = 480;
		
		public static const ERROR:Array = new Array(
		"Неизвестная ощибка",
		"Поле пустое",
		"Вы не указали пол",
		"Вы ввели недопустимые символы",
		"Поле должно содержать буквы одного алфавита",
		"Фамилия и имя должны быть набраны буквами одного алфавита",
		"Фамилия должна быть больше 1 символа"
		);
		
		public static const TIPS:Array = new Array(
		"Поле должно содержать только буквы латинского алфавита или кириллицы",
		"Введите ваш действующий e-mail",
		"Логин должен содержать 2-10 символов, буквы и цифры",
		"Строчные и прописные латинские буквы, цифры, спецсимволы",
		"Повторите введенный вами пароль"
		);
    }
}