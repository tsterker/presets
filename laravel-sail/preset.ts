import { Preset, color } from 'apply';

Preset.setName('laravel-sail');

Preset.execute('composer')
	.withArguments([
		'require',
		'laravel/sail',
		'--dev',
		'--no-interaction',
	])
	.withTitle(`Installing ${color.magenta('sail')} composer package...`);

Preset.extract();

Preset.instruct([
	`Run ${color.magenta('./bin/install.sh')} to install the Sail development environment.`,
	`Laravel Sail documentation: https://laravel.com/docs/8.x/sail`,
]).withHeading("What's next?");