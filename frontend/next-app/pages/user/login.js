import { useRouter } from 'next/router';
import { toast } from 'react-toastify';
import Input from '../../components/Input';
import { useUserStore } from '../../stores/userStore';
import getFormData from '../../utils/getFormData';
import { makePostRequest } from '../../utils/requests';

export default function Login() {
    const setUser = useUserStore((state) => state.setUser);
    const router = useRouter();

    const handleLogin = async (e) => {
        e.preventDefault();
        const data = getFormData(e.target);

        const resData = await makePostRequest(
            'http://localhost:5000/user/login',
            data,
            (resData) => {
                setUser(resData.data);
                toast('Login successful!');
                router.push('/');
            },
            (resData) => {
                toast(resData.message, { type: 'error' });
            }
        );
    };

    const handleSignup = async (e) => {
        e.preventDefault();
        const data = getFormData(e.target);

        const resData = await makePostRequest(
            'http://localhost:5000/user/signup',
            data,
            (resData) => {
                toast('Signup successful! Login to continue!');
            },
            (resData) => {
                toast(resData.message, { type: 'error' });
            }
        );
    };

    return (
        <div className='page'>
            <div className='my-8'>
                <h1>Login User</h1>
                <form method='POST' onSubmit={handleLogin}>
                    <Input name='username' />
                    <Input name='password' type='password' />
                    <button>Login</button>
                </form>
            </div>

            <div className='my-8'>
                <h1>SignUp User</h1>
                <form method='POST' onSubmit={handleSignup}>
                    <Input name='username' />
                    <Input name='name' />
                    <Input name='password' type='password' />
                    <button>Sign Up</button>
                </form>
            </div>
        </div>
    );
}
