export default function InertiaHome({ worlds }) {
  return (
    <div>
      <h1>Hello world</h1>
      <h2>Worlds:</h2>
      {worlds &&
        worlds.map((world) => (
          <div key={world.id}>
            <h3>{world.title}</h3>
            <p>ID: {world.id}</p>
          </div>
        ))}
    </div>
  );
}
