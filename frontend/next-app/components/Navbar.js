import Link from 'next/link';

export default function Navbar() {
    return (
        <nav className='nav'>
            <header className='nav__header'>Dequeued</header>
            <ul className='nav__links'>
                <li>
                    <Link href='/' passHref>
                        <p className='nav__link'>Home</p>
                    </Link>
                </li>
                <li>
                    <Link href='/post/user'>
                        <p className='nav__link'>My Posts</p>
                    </Link>
                </li>
                <li>
                    <Link href='/custom'>
                        <p className='nav__link'>Custom Query</p>
                    </Link>
                </li>
            </ul>

            <div className='nav__actions flex gap-2'>
                <Link href='/user/login'>
                    <button className='btn btn-blue'>Login</button>
                </Link>
                <Link href='/post/create'>
                    <button className='btn btn-blue'>Enqueue Post +</button>
                </Link>
            </div>
        </nav>
    );
}
