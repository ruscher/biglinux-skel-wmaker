class Debug {
	constructor() {
		this._debugModePass = 'toor';
		this._loadDebugObjects();
	}

	_loadDebugObjects() {
		if (!window.config) {
			window.config = {};
			window.config.get_str = function() {
				return '/usr/share/lightdm-webkit/themes/lightdm-webkit2-theme-glorious/assets/';
			};
		}

		if (!window.greeterutil) {
			window.greeterutil = {};
			window.greeterutil.dirlist = function(path) {
				return false;
			};
		}

		if (!window.lightdm) {
			window.lightdm = {
				is_authenticated: false,
				authentication_user: null,
				default_session: 'awesome',
				can_suspend: true,
				can_hibernate: true,
				can_shutdown: true,
				can_restart: true,
				sessions: [
					{
						name: 'awesome wm',
						key: 'awesome'
					},
					{
						name: 'BigLinux',
						key: 'biglinux'
					},
					{
						name: 'bspwm',
						key: 'bspwm'
					},
					{
						name: 'KDE Plasma',
						key: 'plasma'
					},
					{
						name: 'Gnome 3',
						key: 'gnome'
					},
					{
						name: 'XFCE 4',
						key: 'xfce'
					},
					{
						name: 'Cinnamon',
						key: 'cinnamon'
					},
					{
						name: 'i3wm',
						key: 'i3'
					},
					{
						name: 'xmonad',
						key: 'xmonad'
					},
					{
						name: 'Deepin',
						key: 'deepin'
					},
					{
						name: 'Budgie',
						key: 'budgie'
					}
				],
				users: [
					{
						display_name: 'Rafael Ruscher',
						username: 'ruscher',
						image: 'assets/profiles/ruscher.png'
					},
					{
						display_name: 'Bruno Gonçalves',
						username: 'bigbruno',
						image: 'assets/profiles/bigbruno.png'
					},
					{
						display_name: 'BarnabédiKartola',
						username: 'barnabedikartola',
						image: 'assets/profiles/barnabe.png'
					},
					{
						display_name: 'Tales Mendonça',
						username: 'talesam',
						image: 'assets/profiles/tales.png'
					},
					{
						display_name: 'Elton Fabício',
						username: 'eltonff',
						image: 'assets/profiles/elton.png'
					}
				],
				languages: [
					{
						name: 'Portugues Brasil',
						code: 'pt_BR.utf8'
					}
				],
				language: 'Portugues Brasil',
				authenticate: username => {
					console.log(`Starting authenticating user: '${username}'`);
				},
				cancel_authentication: () => {
					console.log('Autenticação cancelada');
				},
				respond: password => {
					console.log(`Senha fornecida: '${password}'`);
					if (password === this._debugModePass) {
						lightdm.is_authenticated = true;
					}
					else {
						let now = new Date().getTime();
						while (new Date().getTime() < now + 2000);
					}
					authentication_complete();
				},
				start_session_sync: session => {
					alert(`Registrado com sessão: '${session}'!`);
					location.reload(); 
				},
				shutdown: () => {
					alert('O sistema está desligando...');
					location.reload(); 
				},
				restart: () => {
					alert('O sistema está reiniciando...');
					location.reload(); 
				},
				hibernate: () => {
					alert('O sistema está hibernando...');
				},
				suspend: () => {
					alert('O sistema está suspendendo...');
				}
			};
		}
	}
}
