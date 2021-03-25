import { Preset, color } from 'apply';

Preset.setName('tsterker-presets');

Preset.instruct([
	`This is a ${color.magenta('monorepo')} for presets.`,
	`Apply with the ${color.magenta('--path')} option to apply a specific preset (subdirectory).`,
	`Check the preset documentation for details: https://usepreset.dev/docs/guides/hosting/#community-organizations`
]).withHeading("How to use?");
