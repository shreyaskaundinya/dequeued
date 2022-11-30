import { userStore } from '../../../stores/users';

/** @type {import('./$types').Actions} */
export const actions = {
	login: async (event) => {
		const formdata = await event.request.formData();
		const data = Object.fromEntries(formdata.entries());

		const res = await fetch('http://localhost:5000/user/login', {
			method: 'POST',
			body: JSON.stringify(data)
		});
		if (res.ok) {
			const resData = await res.json();
			userStore.set(resData.data);
			// throw redirect(308, '/');
			// return { headers: { location: '/' }, status: 308 };
		} else {
			console.error(res.status);
			// return { headers: { location: '/' }, status: 308 };
		}
	},
	signup: async (event) => {
		const res = await event.request.formData();
		const data = Object.fromEntries(res.entries());

		fetch('http://localhost:5000/user/signup', { method: 'POST', body: JSON.stringify(data) })
			.then((res) => res.json())
			.then((data) => {
				console.log(data);
			})
			.catch((error) => {
				console.error(error);
			});
	}
};
