import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import Navbar from '../components/Navbar';
import '../styles/globals.css';

function MyApp({ Component, pageProps }) {
    return (
        <div className='flex'>
            <Navbar />
            <div className='flex-1'>
                <Component {...pageProps} />
            </div>
            <ToastContainer />
        </div>
    );
}

export default MyApp;
